class AddRepresentiveToAddressStation < ActiveRecord::Migration[5.2]
  def change
    add_column :address_stations, :representive, :integer, :after => :line_company_name_omit
  end
end
