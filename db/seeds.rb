# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CSV.foreach('db/stations.csv') do |row|
Station.create(
:name => row[0],
:original_name => row[1],
:area_id => row[2],
:prefecture_id => row[3],
:zone_id => row[4],
:city_id => row[5],
:latitude => row[6],
:longitude => row[7],
:somusho_station_code => row[8],
:somusho_station_group_code => row[9],
:station_group_no => row[10],
:station_group_name => row[11])
end