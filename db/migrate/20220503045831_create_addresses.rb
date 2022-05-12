class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string    :address, null: false, comment: "最寄駅付与対象の住所"
      t.string    :address_adjusted, comment: "最寄駅付与対象の住所（緯度軽度が引き当たらない場合の修正結果）"
      t.decimal   :latitude,  precision: 11, scale: 8, comment: "住所の緯度"
      t.decimal   :longitude,  precision: 11, scale: 8, comment: "住所の経度" 
      t.integer   :got_near_stations,  comment: "距離1.2km以内の駅取得が完了したら付与"
      t.timestamps
    end
  end
end
