class CreateTempStationGroupsOrderByDistances < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_station_groups_order_by_distances do |t|
      t.integer   :nursery_no, null: false,  comment: "保育園no"   
      t.string    :nursery_name, null: false, comment: "保育園名"
      t.text      :address, comment: "住所"
      t.integer   :station_id, comment: "最寄駅_id"   
      t.string    :station_name, comment: "最寄駅名"
      t.integer   :station_group_no, comment: "最寄駅の所属する駅グループno"  
      t.string    :station_group_name, comment: "最寄駅グループ名"
      t.decimal   :station_latitude, precision: 11, scale: 8, comment: "駅経度"
      t.decimal   :station_longitude, precision: 11, scale: 8, comment: "駅緯度"       
      t.decimal   :distance, precision: 11, scale: 2, comment: "最寄駅からの距離（km）_geocoder"
      t.integer   :distance_rank, comment: "保育園から距離が近い順_geocoder"
      t.timestamps   
    end
  end
end
