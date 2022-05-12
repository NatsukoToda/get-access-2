class RenameSomushoStationGroupCodeColumnToAddressStations < ActiveRecord::Migration[5.2]
  def up
    rename_column :address_stations, :somusho_station_group_code, :station_g_code
  end
end
