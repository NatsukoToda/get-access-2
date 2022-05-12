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

ActiveRecord::Schema.define(version: 2022_05_11_131329) do

  create_table "address_station_for_displays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "address", null: false, comment: "最寄駅付与対象の住所"
    t.decimal "latitude", precision: 11, scale: 8, comment: "住所の緯度"
    t.decimal "longitude", precision: 11, scale: 8, comment: "住所の経度"
    t.integer "station_g_code", null: false, comment: "1.2km以内にある駅の駅.jpの駅グループコード"
    t.integer "nearest_station_no", null: false, comment: "駅グループの中で最も近い駅の保活のミカタの駅no"
    t.string "nearest_station_name", null: false, comment: "駅グループの中で最も近い駅の保活のミカタの駅名"
    t.decimal "distance", precision: 11, scale: 2, comment: "駅グループの中で最も近い駅と住所間の距離（km）_geocoder"
    t.integer "walking_time", comment: "駅グループの中で最も近い駅と住所間の徒歩時間（分）_gmap_api"
    t.text "text_for_display", comment: "サイト表示用の最寄駅情報（駅グループの内訳がわかるもの）"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "address_stations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "address", null: false, comment: "最寄駅付与対象の住所"
    t.decimal "latitude", precision: 11, scale: 8, comment: "住所の緯度"
    t.decimal "longitude", precision: 11, scale: 8, comment: "住所の経度"
    t.integer "station_no", null: false, comment: "1200m以内の距離にある駅の保活のミカタの駅no"
    t.integer "station_code", null: false, comment: "1.2km以内にある駅の駅.jpの駅コード"
    t.integer "station_g_code", null: false, comment: "1.2km以内にある駅の駅.jpの駅グループコード"
    t.decimal "distance", precision: 11, scale: 2, comment: "住所と駅間の距離（km）_geocoder"
    t.string "station_name"
    t.string "line_company_name_omit"
    t.integer "representive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "address", null: false, comment: "最寄駅付与対象の住所"
    t.string "address_adjusted", comment: "最寄駅付与対象の住所（緯度軽度が引き当たらない場合の修正結果）"
    t.decimal "latitude", precision: 11, scale: 8, comment: "住所の緯度"
    t.decimal "longitude", precision: 11, scale: 8, comment: "住所の経度"
    t.integer "got_near_stations", comment: "距離1.2km以内の駅取得が完了したら付与"
    t.integer "got_access"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_companies", primary_key: "code", id: :integer, comment: "路線を運営する事業者コード", default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "路線を運営する事業者名"
    t.string "name_omit", null: false, comment: "事業者名の略称"
    t.integer "close_flag", comment: "閉業フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lines", primary_key: "code", id: :integer, comment: "路線コード", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "路線名"
    t.string "name_omit", null: false, comment: "路線の略称"
    t.integer "line_company_code", comment: "路線の運営事業者コード"
    t.integer "close_flag", comment: "閉業フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "stations", primary_key: "no", id: :integer, comment: "プライマリーキー", default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "駅名（沿線補足）"
    t.integer "line_company_code", null: false, comment: "事業者コード"
    t.integer "line_code", null: false, comment: "路線コード"
    t.integer "area_no", null: false, comment: "住所_エリア"
    t.integer "prefecture_no", null: false, comment: "住所_都道府県"
    t.integer "zone_no", comment: "住所_地区（23区・23区外等）"
    t.integer "city_no", null: false, comment: "住所_市区町村（大）"
    t.integer "district_no", null: false, comment: "住所_市区町村（小）"
    t.decimal "latitude", precision: 11, scale: 8, null: false, comment: "緯度"
    t.decimal "longitude", precision: 11, scale: 8, null: false, comment: "経度"
    t.integer "station_code", null: false, comment: "駅.jpの駅コード"
    t.integer "station_g_code", null: false, comment: "駅.jpの駅グループコード"
    t.integer "sort", null: false, comment: "駅を路線登場順に並び替えるための番号（[sort]＋[somusho_station_code]で昇順）"
    t.integer "close_flag", comment: "閉鎖駅フラグ"
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
