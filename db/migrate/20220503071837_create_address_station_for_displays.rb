class CreateAddressStationForDisplays < ActiveRecord::Migration[5.2]
  def change
    create_table :address_station_for_displays do |t|
      t.string    :address, null: false, comment: "最寄駅付与対象の住所"
      t.decimal   :latitude,  precision: 11, scale: 8, comment: "住所の緯度"
      t.decimal   :longitude,  precision: 11, scale: 8, comment: "住所の経度"   
      t.integer   :station_g_code, null: false, comment: "1.2km以内にある駅の駅.jpの駅グループコード" 
      t.integer   :nearest_station_no, null: false, comment: "駅グループの中で最も近い駅の保活のミカタの駅no"
      t.string    :nearest_station_name, null: false, comment: "駅グループの中で最も近い駅の保活のミカタの駅名"
      t.decimal   :distance, precision: 11, scale: 2, comment: "駅グループの中で最も近い駅と住所間の距離（km）_geocoder"
      t.integer   :walking_time, comment: "駅グループの中で最も近い駅と住所間の徒歩時間（分）_gmap_api"
      t.text      :text_for_display, comment: "サイト表示用の最寄駅情報（駅グループの内訳がわかるもの）"
      t.timestamps null: true   
    end
  end
end
