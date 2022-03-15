class CreateTempStationsWithDistances < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_stations_with_distances do |t|

      t.timestamps
    end
  end
end
