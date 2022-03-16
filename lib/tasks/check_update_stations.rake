# CSVファイルを扱う宣言
require 'csv'

namespace :check_update_stations do
  # タスクの説明
  desc "駅一覧を最新化（廃止駅・追加駅反映など）した際に、最寄駅が変更されていないかチェックするタスク"
  # 作業手順
  # ①最新の駅情報をstations.csvに上書き
  # ②過去に最寄駅付与済の保育園情報をnurseries_to_check_aceess.csvの名称で保存
  # ③このrake taskを実行（＄ rake check_update_stations:check_update_stations）
  # ④TempStationGroupsOrderByDistanceと現在利用中のnursery_stationでnursery_no＋distance_rankに紐づく駅とその距離に差分があるものを抽出し、get-accessのrake taskを実施
  # タスク名 => check_update_stations
  task check_update_stations: :environment do
   # 一時的に生成する保育園住所と全駅・全駅グループとの距離テーブルと配列をリセット
  Nursery.destroy_all
  TempStationsWithDistance.destroy_all
  TempStationGroupsOrderByDistance.destroy_all 
  # ①チェック対象の保育園情報インポート
    # 今回最寄駅を付与したい保育園データをアップロード
    CSV.foreach('db/nurseries_to_check_aceess.csv') do |row|
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
      near_three_station_groups.each.with_index(1) do |station_group,i|
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
          :distance => station_group.distance,
          :distance_rank => i
          )
      end
        # googleからスクレイピングと認定されない為に処理に間をあける
        sleep 2
    end
  end
end    

