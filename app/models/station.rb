class Station < ApplicationRecord
  has_many :address_stations, foreign_key: "station_no", primary_key: "no"
  belongs_to :line_company, foreign_key: 'line_company_code'
  belongs_to :line, foreign_key: 'line_code'
  # scopeで検索しようとトライ。使ってない。
  scope :join_address_stations, -> {joins(:address_stations)}
  scope :find_station_name_by_address, ->(address) { joins(:address_stations).where(address_stations: { address: address })[0].name }
  scope :find_line_name_all, ->(address) { joins(:address_stations).where(address_stations: { address: address })[0].name }
  # https://teratail.com/questions/9188
  # https://zenn.dev/emono/articles/4992222541173b
end
