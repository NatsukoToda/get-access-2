class AddressStation < ApplicationRecord
  belongs_to :station, foreign_key: "station_no", primary_key: "no"
  scope :join_station, -> {joins(:station)}
end
