
# CSVファイルを扱う宣言
require 'csv'

namespace :set_lat_lon do
  # タスクの説明
  desc "①最寄駅付与対象の保育園情報インポート・②緯度軽度付与"
  # 作業手順
  # ①DBを再構築（＄rake db:migrate:reset）
  # ②最寄駅付与対象の保育園情報をnurseries_without_aceess.csvの名前で保存
  # ③このrake taskを実行（＄rake set_lat_lon）
  task set_lat_lon: :environment do
  # ①最寄駅付与対象の保育園情報インポート
    # 今回最寄駅を付与したい保育園データをアップロード
    unless Nursery.exists?
      CSV.foreach('db/nurseries_without_access.csv') do |row|
        Nursery.create!(
        :nursery_no => row[0],
        :nursery_name => row[1],
        :nursery_name_without_space => row[2],
        :address => row[3])
      end
    end
  # ②緯緯度軽度付与
    nurseries = Nursery.where(latitude: nil).where(longitude: nil)
    nurseries.each do |nursery|
      geocode = Geocoder.coordinates(nursery.address)
      unless geocode.nil?
        nursery.latitude = geocode[0]
        nursery.longitude =geocode[1]
        nursery.save!
      # googleからスクレイピングと認定されない為に処理に間をあける
      sleep 2 
      end
    end  
  end
end
