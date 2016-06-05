CSV.foreach("db/RAINN_centers.csv") do |row|
  browser = Watir::Browser.new

  browser.goto(row[0])
  sleep(rand(1..4))
  doc = Nokogiri::HTML.parse(browser.html)

  service_provider = {}

  text                                  = doc.xpath("//address").first.text
  info                                  = doc.xpath("//small")
  services                              = info[0].text.gsub(/\s+/, ' ')
  populations                            = info[2].text.gsub(/\s+/, ' ')
  service_provider[:name]               = doc.xpath('//h3').children.text
  service_provider[:telephone]          = /(?<= Telefonico : ).{14}/.match(text).to_s
  service_provider[:tty]                = /(?<= Ayuda: ).{14}/.match(text).to_s
  service_provider[:zip]                = /\b\d{5}\b/.match(text).to_s
  service_provider[:website]            = /(http|www).*/.match(text).to_s
  service_provider[:services_offered]   = /(?<= offered: ).*/.match(services).to_s
  service_provider[:populations_served] = /(?<= served: ).*/.match(populations).to_s

  @client = GooglePlaces::Client.new(ENV["RILEY_GP_API_KEY"])
  @gp_result = @client.spots_by_query("#{service_provider[:name]} #{service_provider[:zip]}")

  unless @gp_result.empty?
    service_provider[:address]  = @gp_result[0].formatted_address
    service_provider[:lat]      = @gp_result[0].lat
    service_provider[:lng]      = @gp_result[0].lng
    service_provider[:place_id] = @gp_result[0].place_id
  end

  @service_provider = ServiceProvider.new(service_provider)

  if @service_provider.save
    p @service_provider
  else
    p @service_provider
    break
  end

  sleep(rand(1..4))
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# require 'csv'

# @client = GooglePlaces::Client.new(ENV["GP_BROWSER_API_KEY"])

# CSV.foreach("db/cities.csv", :headers => true, :header_converters => :symbol, :converters => :all) do |row|

#   @centers = @client.spots_by_query("Rape crisis center near " + row[:city] + " " + row[:state])

#     @centers.each do |center|
#       ServiceProvider.create(name: center["name"], address: center["formatted_address"], lat: center["lat"], lng: center["lng"], place_id: center["place_id"])
#     end

# end

# CSV.foreach("db/centers.csv", :headers => true, :header_converters => :symbol, :converters => :all) do |row|

#   ServiceProvider.create(name: row[:name], address: row[:address], lat: row[:lat], lng: row[:lng], place_id: row[:place_id])

# end



# end
