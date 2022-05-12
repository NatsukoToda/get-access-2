# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# CSV.foreach('db/line_companies.csv') do |row|
# LineCompany.create(
# :code => row[0],
# :name => row[1],
# :name_omit => row[2],
# :close_flag => row[3]
# )
# end

# CSV.foreach('db/stations.csv') do |row|
# Station.create(
# :no => row[0],
# :name => row[1],
# :line_company_code => row[2],
# :line_code => row[3],
# :area_no => row[4],
# :prefecture_no => row[5],
# :zone_no => row[6],
# :city_no => row[7],
# :district_no => row[8],
# :latitude => row[9],
# :longitude => row[10],
# :station_code => row[11],
# :station_g_code => row[12],
# :sort => row[13],
# :close_flag => row[14]
# )
# end

CSV.foreach('db/lines.csv') do |row|
Line.create(
:code => row[0],
:name => row[1],
:name_omit => row[2],
:line_company_code => row[3],
:close_flag => row[4]
)
end

