class CreateAddressStations < ActiveRecord::Migration[5.2]
  def change
    create_table :address_stations do |t|
      t.string    :address, null: false, comment: "最寄駅付与対象の住所"
      t.decimal   :latitude,  precision: 11, scale: 8, comment: "住所の緯度"
      t.decimal   :longitude,  precision: 11, scale: 8, comment: "住所の経度"   
      t.integer   :station_no, null: false, comment: "1200m以内の距離にある駅の保活のミカタの駅no"
      t.integer   :somusho_station_code, null: false, comment: "1200m以内の距離にある駅の総務省駅コード"
      t.integer   :somusho_station_group_code, null: false, comment: "1200m以内の距離にある駅の総務省駅グループコード" 
      t.decimal   :distance, precision: 11, scale: 2, comment: "住所と駅間の距離（km）_geocoder"
      t.timestamps null: true   
      t.timestamps
    end
  end
end

