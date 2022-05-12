class ChangeCommentOfStationGCodeToAddressStations < ActiveRecord::Migration[5.2]
  def up
    change_column :address_stations, :station_g_code, :integer, comment: '1.2km以内にある駅の駅.jpの駅グループコード'
  end
end
