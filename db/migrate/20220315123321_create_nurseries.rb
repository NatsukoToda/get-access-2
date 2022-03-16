class CreateNurseries < ActiveRecord::Migration[5.2]
  def change
    create_table :nurseries do |t|
      t.integer   :nursery_no, null: false, comment: "最寄駅付与対象の保育園no"
      t.string    :nursery_name, null: false,  comment: "最寄駅付与対象の保育園名"
      t.string    :nursery_name_without_space, null: false,  comment: "最寄駅付与対象の保育園名（全角補正・スペース除去等データの一致確認用の保育園名）"
      t.text      :address, null: false, comment: "住所"
      t.decimal   :latitude, precision: 11, scale: 8, comment: "経度"
      t.decimal   :longitude, precision: 11, scale: 8, comment: "緯度"
      t.integer   :done, comment: "最寄駅付与が完了したら立てるフラグ"
      t.timestamps         
    end
  end
end
