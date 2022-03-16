class CreateNurseryStations < ActiveRecord::Migration[5.2]
  def change
    create_table :nursery_stations, id: false do |t|
      t.integer   :nursery_no, null: false,  comment: "保育園no"   
      t.string    :nursery_name, null: false, comment: "保育園名"
      t.string    :nursery_name_without_space, null: false, comment: "データ一致確認用の保育園名（全角半角化・スペース除外）"
      t.text      :address, null: false, comment: "住所"
      t.integer   :station_id, comment: "最寄駅_id"   
      t.string    :station_name, comment: "最寄駅名"
      t.integer   :station_group_no, comment: "最寄駅の所属する駅グループno"  
      t.string    :station_group_name, comment: "最寄駅グループ名"
      t.decimal   :distance, precision: 11, scale: 2, comment: "最寄駅からの距離（km）_geocoder"
      t.integer   :distance_rank, comment: "保育園から距離が近い順_geocoder"   
      t.text      :walking_time_text, null: false, comment: "最寄駅からの徒歩時間_gmap_api"
      t.integer   :walking_time, comment: "最寄駅からの徒歩時間（分）_gmap_api"
      t.decimal   :nursery_latitude, precision: 11, scale: 8, comment: "経度"
      t.decimal   :nursery_longitude, precision: 11, scale: 8, comment: "緯度"
      t.timestamps    
    end
  end
end
