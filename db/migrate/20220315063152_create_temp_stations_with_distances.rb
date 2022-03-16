class CreateTempStationsWithDistances < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_stations_with_distances do |t|
      t.integer   :nursery_no, null: false,  comment: "保育園no"   
      t.string    :nursery_name, null: false, comment: "保育園名"
      t.text      :address, comment: "住所"
      t.integer   :station_id, comment: "最寄駅_id"   
      t.string    :station_name, comment: "最寄駅名"
      t.integer   :station_group_no, comment: "最寄駅の所属する駅グループno"  
      t.string    :station_group_name, comment: "最寄駅グループ名"
      t.decimal   :station_latitude, precision: 11, scale: 8, comment: "駅経度"
      t.decimal   :station_longitude, precision: 11, scale: 8, comment: "駅緯度"      
      t.decimal   :distance, precision: 11, scale: 2, comment: "最寄駅からの徒歩距離（km）_geocoder"
      t.timestamps
    end
  end
end
