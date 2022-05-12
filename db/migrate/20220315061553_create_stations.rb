class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations, id: false do |t|
      t.integer   :no, null: false, comment: "プライマリーキー"
      t.string    :name, null: false, comment: "駅名（沿線補足）"
      t.integer   :line_company_code, null: false, comment: "事業者コード"
      t.integer   :line_code, null: false, comment: "路線コード"
      t.integer   :area_no, null: false, comment: "住所_エリア"
      t.integer   :prefecture_no, null: false, comment: "住所_都道府県"
      t.integer   :zone_no, null: true, comment: "住所_地区（23区・23区外等）"
      t.integer   :city_no, null: false, comment: "住所_市区町村（大）"
      t.integer   :district_no, null: false, comment: "住所_市区町村（小）"
      t.decimal   :latitude, null: false,  precision: 11, scale: 8, comment: "緯度"
      t.decimal   :longitude, null: false,  precision: 11, scale: 8, comment: "経度"   
      t.integer   :station_code, null: false, comment: "駅.jpの駅コード"
      t.integer   :station_g_code, null: false, comment: "駅.jpの駅グループコード"      
      t.integer   :sort, null: false, comment: "駅を路線登場順に並び替えるための番号（[sort]＋[somusho_station_code]で昇順）"   
      t.integer   :close_flag, comment: "閉鎖駅フラグ"       
      t.timestamps null: true   
    end
    execute "ALTER TABLE stations ADD PRIMARY KEY (no);"
  end
end