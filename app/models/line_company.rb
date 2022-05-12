class LineCompany < ApplicationRecord
  has_many :stations
  scope :find_line_name_all, ->(station) { joins(:address_stations).where(address_stations: { address: address })[0].name }
end
