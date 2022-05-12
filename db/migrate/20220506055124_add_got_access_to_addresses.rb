class AddGotAccessToAddresses < ActiveRecord::Migration[5.2]
  def up
    add_column :addresses, :got_access, :integer, :after => :got_near_stations
  end
end
