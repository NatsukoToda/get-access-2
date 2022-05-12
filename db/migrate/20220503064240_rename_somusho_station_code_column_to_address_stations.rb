class RenameSomushoStationCodeColumnToAddressStations < ActiveRecord::Migration[5.2]
  def up
    rename_column :address_stations, :somusho_station_code, :station_code
  end
end
