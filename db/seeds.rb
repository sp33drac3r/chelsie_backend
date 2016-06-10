User.create(username: 'chelsie', email: 'chelsie@chelsie.com', password: '123')

schools = ['American Public University System (American Military University)',  'American River College (ARC)', 'Arizona State University', 'Ashford University (AU)',  'Austin Community College District (ACC)',  'Boston University (BU)', 'Brigham Young University - Idaho (BYU-I) ',  'Brigham Young University (BYU) ',  'Broward College (BCC)',  'California State University - Fullerton (CSUF)', 'California State University - Long Beach (CSULB)', 'California State University - Northridge (CSUN)',  'California State University - Sacramento (Sacramento State)',  'Capella University', 'College of DuPage (C.O.D.)', 'College of Southern Nevada (CSN)', 'Colorado State University (CSU)',  'East Los Angeles College (ELAC)',  'Excelsior College (EC)', 'Florida Atlantic University (FAU)',  'Florida International University (FIU)', 'Florida State University (FSU)', 'George Mason University (Mason)',  'Georgia State University (GSU)', 'Grand Canyon University (GCU)',  'Houston Community College System ',  'Indiana University - Bloomington (IU)',  'Indiana University - Purdue University - Indianapolis (IUPUI)',  'Iowa State University',  'Kaplan University',  'Kent State University - Kent Campus',  'Liberty University (LU)',  'Lone Star College - Montgomery (LSC) ',  'Louisiana State University (LSU)', 'Miami Dade College (MDC) ',  'Michigan State University',  'New York University (NYU)',  'North Carolina State University at Raleigh (NC State)',  'Northern Virginia Community College (NVCC)', 'Ohio State University',  'Ohio University',  'Pennsylvania State University',  'Portland Community College (PCC)', 'Purdue University (Purdue-West Lafayette)',  'Rutgers University - New Brunswick (Rutgers, The State University)', 'Salt Lake Community College (SLCC) ',  'San Diego State University (SDSU)',  'San Francisco State University (SFSU)',  'San Jose State University (SJSU)', 'Santa Ana College (SAC)',  'Santa Monica College (SMC)', 'South Texas College',  'Southern New Hampshire University (SNHU)', 'St Petersburg College (SPC)',  'Tarrant County College (TCC) ',  'Temple University',  'Texas A&M University (Texas A&M) ',  'Texas State University (Texas State) ',  'Texas Tech University (TTU)',  'The University of Alabama',  'The University of Tennessee',  'The University of Texas at Arlington (UT Arlington)',  'The University of Texas at Austin (UT Austin)',  'University at Buffalo (UB)', 'University of Arizona (UA)', 'University of California - Berkeley (UC Berkeley)',  'University of California - Davis (UC Davis)',  'University of California - Irvine (UCI)',  'University of California - Los Angeles (UCLA)',  'University of California - San Diego (UCSD)',  'University of Central Florida (UCF) ', 'University of Cincinnati (UC)',  'University of Colorado at Boulder (CU Boulder)', 'University of Florida (UF)', 'University of Georgia (UGA)',  'University of Houston (UH) ',  'University of Illinois at Urbana - Champaign (UIUC)',  'University of Iowa (UI)',  'University of Kentucky (UK)',  'University of Maryland - College Park (UM)', 'University of Maryland - University College (UMUC)', 'University of Michigan - Ann Arbor (U-M)', 'University of Minnesota - Twin Cities (U of M)', 'University of Missouri - Columbia (Mizzou)', 'University of North Carolina at Chapel Hill (UNC)',  'University of North Texas (UNT)',  'University of South Carolina - Columbia (SC)', 'University of South Florida (USF)',  'University of Southern California (USC)',  'University of Utah (The U)', 'University of Washington - Seattle Campus (UW-Seattle)', 'University of Wisconsin',  'Utah Valley University (UVU) ',  'Valencia College (Valencia CC) ',  'Virginia Commonwealth University (VCU)', 'Virginia Polytechnic Institute and State University (Virginia Tech)',  'Walden University (Walden U)', 'West Virginia University (WVU)', 'Western Governors University (WGU) ']


schools.each do |school|
  School.create(name: school)
end

# School.create(
#   name: 'Ohio State University',
#   address: "Columbus, OH 43210",
#   lat: 40.0142,
#   lng: -83.0309
# )

# School.create(
#   name: 'Kenyon College',
#   address: "103 College Rd, Gambier, OH 43022",
#   lat: 40.3719,
#   lng: -82.3983
# )

# School.create(
#   name: 'University of Southern California',
#   address: "Los Angeles, CA",
#   lat: 34.0224,
#   lng: -118.2851
# )

# School.create(
#   name: 'Stanford University',
#   address: "450 Serra Mall, Stanford, CA 94305",
#   lat: 37.4275,
#   lng: -122.1697
# )

# School.create(
#   name: 'University of San Francisco',
#   address: "4202 E Fowler Ave, Tampa, FL 33620",
#   lat: 28.0587,
#   lng: -82.4139
# )

20.times do
  User.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: '123'
    )
end

40.times do
  Post.create(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph(8),
    user_id: rand(1..20),
    school_id: rand(1..100)
    )
end

60.times do
  Comment.create(
    body: Faker::Hipster.paragraph(2),
    user_id: rand(1..20),
    post_id: rand(1..40)
    )
end

12.times do
  Flag.create(
    user_id: rand(1..20),
    flaggable_id: rand(1..40),
    flaggable_type: ["Comment","Post"].sample
    )
end



######### RAINN CENTERS SCRAPE - DO NOT UNCOMMENT ##############
# CSV.foreach("db/RAINN_centers.csv") do |row|
#   browser = Watir::Browser.new

#   browser.goto(row[0])
#   sleep(rand(1..4))
#   doc = Nokogiri::HTML.parse(browser.html)

#   service_provider = {}

#   text                                  = doc.xpath("//address").first.text
#   info                                  = doc.xpath("//small")
#   services                              = info[0].text.gsub(/\s+/, ' ')
#   populations                            = info[2].text.gsub(/\s+/, ' ')
#   service_provider[:name]               = doc.xpath('//h3').children.text
#   service_provider[:telephone]          = /(?<= Telefonico : ).{14}/.match(text).to_s
#   service_provider[:tty]                = /(?<= Ayuda: ).{14}/.match(text).to_s
#   service_provider[:zip]                = /\b\d{5}\b/.match(text).to_s
#   service_provider[:website]            = /(http|www).*/.match(text).to_s
#   service_provider[:services_offered]   = /(?<= offered: ).*/.match(services).to_s
#   service_provider[:populations_served] = /(?<= served: ).*/.match(populations).to_s

#   @client = GooglePlaces::Client.new(ENV["RILEY_GP_API_KEY"])
#   @gp_result = @client.spots_by_query("#{service_provider[:name]} #{service_provider[:zip]}")

#   unless @gp_result.empty?
#     service_provider[:address]  = @gp_result[0].formatted_address
#     service_provider[:lat]      = @gp_result[0].lat
#     service_provider[:lng]      = @gp_result[0].lng
#     service_provider[:place_id] = @gp_result[0].place_id
#   end

#   @service_provider = ServiceProvider.new(service_provider)

#   if @service_provider.save
#     p @service_provider
#   else
#     p @service_provider
#     break
#   end

#   sleep(rand(1..4))
# end


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



