class CreateNurseryStations < ActiveRecord::Migration[5.2]
  def change
    create_table :nursery_stations do |t|

      t.timestamps
    end
  end
end
