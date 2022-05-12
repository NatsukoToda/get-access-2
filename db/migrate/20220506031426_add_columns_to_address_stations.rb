class AddColumnsToAddressStations < ActiveRecord::Migration[5.2]
  def up
    add_column :address_stations, :line_company_name_omit, :string, :after => :distance
    add_column :address_stations, :station_name, :string, :after => :distance
  end
end
