namespace :create_address_stations_table_for_display do
  # タスクの説明
  desc "住所から距離が1.2km以内以内にある最寄駅を駅グループ毎にまとめて表示用に補正"
  # 作業手順
  # このrake taskを実行（＄rake create_address_stations_table_for_display:create_address_stations_table_for_display)
  task create_address_stations_table_for_display: :environment do
    addresses = Address.where.not(got_near_stations: nil).where.not(latitude: nil)
    addresses.each do |a|
      # ①住所から1.2km以内の駅を近い順に並び替えたテーブルを作成
      near_stations = AddressStation.order(:distance).where(address: a.address)
      # ②①を駅グループ✖️駅名ユニークにする（残るのはその駅グループの中で最も近い駅のみ）
      unique_near_station_groups = near_stations.group(:station_g_code).group(:station_name)
      # ③①を駅グループ✖️駅名✖️路線の運営事業者名（略称）ユニークにする
      unique_line_companies = near_stations.group(:station_g_code).group(:station_name).group(:line_company_name_omit)
      # ②と③を利用しその住所に最も近い駅グループ・駅名について、表示に必要な情報を取得する（全路線、
      unique_near_station_groups.each do |sg|
        as = AddressStationForDisplay.new
        line_companies = unique_line_companies.where(station_g_code: sg.station_g_code).where(station_name: sg.station_name)
        line_companies.each_with_index do |l, i|
          if i==0
            line_all = l.line_company_name_omit
            as.address  = sg.address
            as.latitude = sg.latitude
            as.longitude = sg.longitude
            as.station_g_code = sg.station_g_code
            as.nearest_station_no = sg.station_no
            as.nearest_station_name = sg.station_name
            as.distance = sg.distance
            as.walking_time = "XX"
            as.text_for_display = line_all
            as.save!
          else
            line_all = "#{as.text_for_display}・#{l.line_company_name_omit}"
            as.text_for_display = line_all
            as.save!
          end
        end
      end
    end
  end
end