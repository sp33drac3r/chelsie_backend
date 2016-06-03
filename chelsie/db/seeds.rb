# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

@client = GooglePlaces::Client.new(ENV["GP_BROWSER_API_KEY"])

CSV.foreach("db/cities.csv", :headers => true, :header_converters => :symbol, :converters => :all) do |row|

  @centers = @client.spots_by_query("Rape crisis center near " + row[:city] + " " + row[:state])

    @centers.each do |center|
      ServiceProvider.create(name: center["name"], address: center["formatted_address"], lat: center["lat"], lng: center["lng"], place_id: center["place_id"])
    end

end
