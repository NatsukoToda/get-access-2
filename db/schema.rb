# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_15_123321) do

  create_table "nurseries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "nursery_no", null: false, comment: "最寄駅付与対象の保育園no"
    t.string "nursery_name", null: false, comment: "最寄駅付与対象の保育園名"
    t.string "nursery_name_without_space", null: false, comment: "最寄駅付与対象の保育園名（全角補正・スペース除去等データの一致確認用の保育園名）"
    t.text "address", null: false, comment: "住所"
    t.decimal "latitude", precision: 11, scale: 8, comment: "経度"
    t.decimal "longitude", precision: 11, scale: 8, comment: "緯度"
    t.integer "done", comment: "最寄駅付与が完了したら立てるフラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nursery_stations", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "nursery_no", null: false, comment: "保育園no"
    t.string "nursery_name", null: false, comment: "保育園名"
    t.string "nursery_name_without_space", null: false, comment: "データ一致確認用の保育園名（全角半角化・スペース除外）"
    t.text "address", null: false, comment: "住所"
    t.integer "station_id", comment: "最寄駅_id"
    t.string "station_name", comment: "最寄駅名"
    t.integer "station_group_no", comment: "最寄駅の所属する駅グループno"
    t.string "station_group_name", comment: "最寄駅グループ名"
    t.decimal "distance", precision: 11, scale: 2, comment: "最寄駅からの距離（km）_geocoder"
    t.integer "distance_rank", comment: "保育園から距離が近い順_geocoder"
    t.text "walking_time_text", null: false, comment: "最寄駅からの徒歩時間_gmap_api"
    t.integer "walking_time", comment: "最寄駅からの徒歩時間（分）_gmap_api"
    t.decimal "nursery_latitude", precision: 11, scale: 8, comment: "経度"
    t.decimal "nursery_longitude", precision: 11, scale: 8, comment: "緯度"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "駅名（沿線補足）"
    t.string "original_name", null: false, comment: "駅名"
    t.integer "area_id", null: false, comment: "住所_エリア"
    t.integer "prefecture_id", null: false, comment: "住所_都道府県"
    t.integer "zone_id", comment: "住所_地区（23区・23区外等）"
    t.integer "city_id", null: false, comment: "住所_市区町村"
    t.decimal "latitude", precision: 11, scale: 8, comment: "緯度"
    t.decimal "longitude", precision: 11, scale: 8, comment: "経度"
    t.integer "somusho_station_code", null: false, comment: "総務省の駅コード"
    t.integer "somusho_station_group_code", null: false, comment: "総務省の駅グループコード"
    t.integer "station_group_no", null: false, comment: "保活のミカタの保育園no"
    t.string "station_group_name", null: false, comment: "保活のミカタの保育園名"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temp_station_groups_order_by_distances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "nursery_no", null: false, comment: "保育園no"
    t.string "nursery_name", null: false, comment: "保育園名"
    t.text "address", comment: "住所"
    t.integer "station_id", comment: "最寄駅_id"
    t.string "station_name", comment: "最寄駅名"
    t.integer "station_group_no", comment: "最寄駅の所属する駅グループno"
    t.string "station_group_name", comment: "最寄駅グループ名"
    t.decimal "station_latitude", precision: 11, scale: 8, comment: "駅経度"
    t.decimal "station_longitude", precision: 11, scale: 8, comment: "駅緯度"
    t.decimal "distance", precision: 11, scale: 2, comment: "最寄駅からの距離（km）_geocoder"
    t.integer "distance_rank", comment: "保育園から距離が近い順_geocoder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temp_stations_with_distances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "nursery_no", null: false, comment: "保育園no"
    t.string "nursery_name", null: false, comment: "保育園名"
    t.text "address", comment: "住所"
    t.integer "station_id", comment: "最寄駅_id"
    t.string "station_name", comment: "最寄駅名"
    t.integer "station_group_no", comment: "最寄駅の所属する駅グループno"
    t.string "station_group_name", comment: "最寄駅グループ名"
    t.decimal "station_latitude", precision: 11, scale: 8, comment: "駅経度"
    t.decimal "station_longitude", precision: 11, scale: 8, comment: "駅緯度"
    t.decimal "distance", precision: 11, scale: 2, comment: "最寄駅からの徒歩距離（km）_geocoder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
