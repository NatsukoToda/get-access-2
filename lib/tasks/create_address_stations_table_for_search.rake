namespace :create_address_stations_table_for_search do
  # タスクの説明
  desc "住所から距離が1.2km以内の駅を全て取得"
  # 作業手順
  # ①このrake taskを実行（＄rake create_address_stations_table_for_search:create_address_stations_table_for_search）
  task create_address_stations_table_for_search: :environment do
    all_stations = Station.all
    # 最寄り駅の取得対象＝最寄駅未付与かつ緯度軽度がnilでない住所を抽出
    addresses = Address.where(got_near_stations: nil).where.not(latitude: nil)
    # # 取得対象住所との距離が1.2km以内の駅を全て抽出したテーブルaddress_stationsを作成
    addresses.each do |address|
      all_stations.each do |station|
        distance = Geocoder::Calculations.distance_between([address.latitude,address.longitude],[station.latitude,station.longitude])
        if distance <= 1.2
          AddressStation.create!(
            :address => address.address,
            :latitude => address.latitude,
            :longitude => address.longitude,
            :station_no => station.no,
            :station_code => station.station_code,
            :station_g_code => station.station_g_code,
            :distance => distance,
            :station_name => address.station.name,
            )
        end
      end
      # 1.2km以内の駅取得が完了したフラグを立てる
      address.got_near_stations = 1
      address.save!    
    end
    # all = AddressStation.all
    # all.each do |a|
    #   representive = AddressStation.find_by(address: a.address, station_g_code: a.station_g_code, station_name: a.station_name)
    #   representive.representive = 1
    #   representive.save!
    # end
    representive_stations = AddressStation.where(representive: 1)
    lines = []
    representive_stations.each do |address_station|
      stations = Station.where(station_g_code: address_station.station_g_code, name: address_station.station_name)
      stations.each do |station|
        lines.push(station.line.name_omit)
      end
      unique_line_names = lines.uniq
      text = ""
      unique_line_names.each_with_index do |line_name, i|
        if i==0
          text = " #{line_name} "
        else
          text = " #{text}・#{line_name}  "
        end
      end
      address_station.line_company_name_omit = text
      address_station.save! 
      lines.clear
    end
  end  
end
