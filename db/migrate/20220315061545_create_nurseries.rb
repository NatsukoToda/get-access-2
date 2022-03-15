class CreateNurseries < ActiveRecord::Migration[5.2]
  def change
    create_table :nurseries do |t|

      t.timestamps
    end
  end
end
