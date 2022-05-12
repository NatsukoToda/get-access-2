
# CSVファイルを扱う宣言
require 'csv'

namespace :set_lat_lon do
  # タスクの説明
  desc "①最寄駅付与対象の保育園情報インポート・②緯度軽度付与"
  # 作業手順
  # ①DBを再構築（＄rake db:migrate:reset）
  # ②最寄駅付与対象の住所をaddresses.csvの名前でアップロード
  # ③このrake taskを実行（＄rake set_lat_lon:set_lat_lon）
  task set_lat_lon: :environment do
  # ①最寄駅付与対象の住所インポート
    # 今回最寄駅を付与したい保育園データをアップロード
    unless Address.exists?
      CSV.foreach('db/addresses.csv') do |row|
        Address.create!(
        :address => row[0],
        :address_adjusted => row[1],
        :latitude => row[2],
        :longitude => row[3]
        )
      end
    end
  # ②緯緯度軽度付与
    addresses = Address.where(latitude: nil).where(longitude: nil)
    addresses.each do |address|
      geocode = Geocoder.coordinates(address.address)
      # 元の住所で引き当たらない場合（ビル名が入っているなど）address_adjustedに修正した住所を入力し再度rake taskを実施
      if geocode.nil
        geocode = Geocoder.coordinates(address.address_adjusted)
      end
      unless geocode.nil?
        address.latitude = geocode[0]
        address.longitude =geocode[1]
        address.save!
      # googleからスクレイピングと認定されない為に処理に間をあける
      sleep 2 
      end
    end  
  end
end
