class Nurseries < ApplicationRecord
    # アドレスカラムで緯度軽度取得を実施する
    geocoded_by :address
    before_validation :geocode
end
