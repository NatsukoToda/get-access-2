class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string    :name, null: false, comment: "駅名（沿線補足）"
      t.string    :original_name, null: false, comment: "駅名"
      t.integer   :area_id, null: false, comment: "住所_エリア"
      t.integer   :prefecture_id, null: false, comment: "住所_都道府県"
      t.integer   :zone_id, null: true, comment: "住所_地区（23区・23区外等）"
      t.integer   :city_id, null: false, comment: "住所_市区町村"
      t.decimal   :latitude,  precision: 11, scale: 8, comment: "緯度"
      t.decimal   :longitude,  precision: 11, scale: 8, comment: "経度"   
      t.integer   :somusho_station_code, null: false, comment: "総務省の駅コード"
      t.integer   :somusho_station_group_code, null: false, comment: "総務省の駅グループコード"      
      t.integer   :station_group_no, null: false, comment: "保活のミカタの保育園no"   
      t.string    :station_group_name, null: false, comment: "保活のミカタの保育園名"       
      t.timestamps null: true   
    end
  end
end
