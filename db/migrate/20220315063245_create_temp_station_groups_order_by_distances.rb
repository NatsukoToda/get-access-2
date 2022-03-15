class CreateTempStationGroupsOrderByDistances < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_station_groups_order_by_distances do |t|

      t.timestamps
    end
  end
end
