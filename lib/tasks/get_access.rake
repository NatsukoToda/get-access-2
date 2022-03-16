
# CSVファイルを扱う宣言
require 'csv'

namespace :get_access do
  # タスクの説明
  desc "①最寄駅付与対象の保育園情報インポート・②緯度軽度付与・③最寄駅取得"
  # タスク名 => get_access
  task get_access: :environment do
   # 一時的に生成する保育園住所と全駅・全駅グループとの距離テーブルと配列をリセット
  Nursery.destroy_all
  NurseryStation.destroy_all
  TempStationsWithDistance.destroy_all
  TempStationGroupsOrderByDistance.destroy_all 
  # ①最寄駅付与対象の保育園情報インポート
    # 今回最寄駅を付与したい保育園データをアップロード
    CSV.foreach('db/nurseries_without_aceess.csv') do |row|
      Nursery.create!(
      :nursery_no => row[0],
      :nursery_name => row[1],
      :nursery_name_without_space => row[2],
      :address => row[3])
    end
  # ②緯緯度軽度付与
    nurseries = Nursery.where(latitude: nil)
    nurseries.each do |nursery|
      geocode = Geocoder.coordinates(nursery.address)
      nursery.latitude = geocode[0]
      nursery.longitude =geocode[1]
      nursery.save!
      # googleからスクレイピングと認定されない為に処理に間をあける
      sleep 2 
    end
  
   #③最寄駅取得 
    all_stations = Station.all
    # 緯度軽度がnilでないものについてのみ処理
    nurseries = Nursery.where.not(latitude: nil)
    # 保育園住所と全駅の距離を取得
    nurseries.each do |nursery|
      all_stations.each do |station|
        TempStationsWithDistance.create!(
          :nursery_no => nursery.nursery_no,
          :nursery_name =>nursery. nursery_name,
          :address => nursery.address,
          :station_id => station.id,
          :station_name => station.name,
          :station_group_no => station.station_group_no,
          :station_group_name => station.station_group_name,
          :station_latitude => station.latitude,
          :station_longitude => station.longitude,
          :distance => Geocoder::Calculations.distance_between([nursery.latitude,nursery.longitude],[station.latitude,station.longitude]))
        end
      # 駅を近い順に並び替え、最も近い駅を残して駅グループで重複削除
      all_station_groups = TempStationsWithDistance.order(:distance).group(:station_group_no)
      # 距離が近い順で3駅を取得
      near_three_station_groups = all_station_groups.first(3)
      near_three_station_groups.each do |station_group|
        TempStationGroupsOrderByDistance.create!(
          :nursery_no => station_group.nursery_no,
          :nursery_name =>station_group. nursery_name,
          :address => nursery.address,
          :station_id => station_group.station_id,
          :station_name => station_group.station_name,
          :station_group_no => station_group.station_group_no,
          :station_group_name => station_group.station_group_name,
          :station_latitude => station_group.station_latitude,
          :station_longitude => station_group.station_longitude,          
          :distance => station_group.distance
          )
      end
      # 距離が近い順で3駅を取得し徒歩分数を取得
      TempStationGroupsOrderByDistance.all.each.with_index(1) do |station_group,i|
        uri = URI.escape("https://maps.googleapis.com/maps/api/directions/json?origin=#{nursery.latitude},#{nursery.longitude}&destination=#{station_group[:station_latitude]},#{station_group[:station_longitude]}&mode=walking&key=#{ENV['GOOGLE_MAP_API']}")
        res = HTTP.get(uri).to_s
        response = JSON.parse(res)
        if response.empty?
          raise "google api error"
        else
          if response["routes"].present?
            res_time = response["routes"][0]["legs"][0]["duration"]["text"]
            NurseryStation.create!(
              :nursery_no => station_group[:nursery_no],
              :nursery_name => station_group[:nursery_name],
              :nursery_name_without_space => nursery.nursery_name_without_space,
              :address => station_group[:address],
              :station_id => station_group[:station_id],
              :station_name => station_group[:station_name],
              :station_group_no => station_group[:station_group_no],
              :station_group_name => station_group[:station_group_name],
              :distance => station_group[:distance],
              :walking_time => res_time.delete(" mins").split(/hour/).map(&:to_i).inject{|x,y| x*60+y},
              :walking_time_hour => res_time.delete(" mins").to_i,
              :distance_rank => i,
              :nursery_latitude => nursery.latitude,
              :nursery_longitude => nursery.longitude)
          end
        end
        # googleからスクレイピングと認定されない為に処理に間をあける
        sleep 2
        TempStationsWithDistance.destroy_all
        TempStationGroupsOrderByDistance.destroy_all 
      end
    end
  end
end
