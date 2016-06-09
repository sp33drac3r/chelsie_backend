User.create(username: 'chelsie', email: 'chelsie@chelsie.com', password: '123')

schools = ["Ivy Tech Community College - Central Indiana", "Liberty University (LU)", "Lone Star College - Montgomery (LSC) ", "Miami Dade College (MDC) ", "Grand Canyon University (GCU)", "Texas A&M University (Texas A&M) ", "University of Central Florida (UCF) ", "Ohio State University", "Houston Community College System ", "Western Governors University (WGU) ", "American Public University System (American Military University)", "Walden University (Walden U)", "Kaplan University", "Northern Virginia Community College (NVCC)", "The University of Texas at Austin (UT Austin)", "Ashford University (AU)", "University of Minnesota - Twin Cities (U of M)", "Tarrant County College (TCC) ", "Arizona State University", "Michigan State University", "Florida International University (FIU)", "University of Florida (UF)", "New York University (NYU)", "Rutgers University - New Brunswick (Rutgers, The State University)", "University of Maryland - University College (UMUC)", "Pennsylvania State University", "Indiana University - Bloomington (IU)", "University of Illinois at Urbana - Champaign (UIUC)", "University of Washington - Seattle Campus (UW-Seattle)", "Broward College (BCC)", "University of Michigan - Ann Arbor (U-M)", "Southern New Hampshire University (SNHU)", "Valencia College (Valencia CC) ", "University of Wisconsin", "University of Southern California (USC)", "University of Arizona (UA)", "University of South Florida (USF)", "University of California - Los Angeles (UCLA)", "Excelsior College (EC)", "Florida State University (FSU)", "Austin Community College District (ACC)", "University of Houston (UH) ", "California State University - Northridge (CSUN)", "Purdue University (Purdue-West Lafayette)", "The University of Texas at Arlington (UT Arlington)", "California State University - Fullerton (CSUF)", "University of Maryland - College Park (UM)", "University of California - Berkeley (UC Berkeley)", "Temple University", "California State University - Long Beach (CSULB)", "Texas State University (Texas State) ", "Brigham Young University - Idaho (BYU-I) ", "University of North Texas (UNT)", "The University of Alabama", "East Los Angeles College (ELAC)", "College of Southern Nevada (CSN)", "University of Missouri - Columbia (Mizzou)", "University of Cincinnati (UC)", "University of Georgia (UGA)", "Texas Tech University (TTU)", "Capella University", "University of California - Davis (UC Davis)", "Iowa State University", "North Carolina State University at Raleigh (NC State)", "George Mason University (Mason)", "San Diego State University (SDSU)", "University of South Carolina - Columbia (SC)", "San Jose State University (SJSU)", "St Petersburg College (SPC)", "Georgia State University (GSU)", "University of Colorado at Boulder (CU Boulder)", "Boston University (BU)", "University of Utah (The U)", "Colorado State University (CSU)", "Utah Valley University (UVU) ", "Virginia Polytechnic Institute and State University (Virginia Tech)", "Louisiana State University (LSU)", "Portland Community College (PCC)", "Virginia Commonwealth University (VCU)", "University of California - San Diego (UCSD)", "Indiana University - Purdue University - Indianapolis (IUPUI)", "Brigham Young University (BYU) ", "The University of Tennessee", "Florida Atlantic University (FAU)", "Salt Lake Community College (SLCC) ", "South Texas College", "Santa Monica College (SMC)", "University of California - Irvine (UCI)", "University at Buffalo (UB)", "University of Iowa (UI)", "Santa Ana College (SAC)", "Kent State University - Kent Campus", "College of DuPage (C.O.D.)", "San Francisco State University (SFSU)", "California State University - Sacramento (Sacramento State)", "Ohio University", "University of Kentucky (UK)", "West Virginia University (WVU)", "University of North Carolina at Chapel Hill (UNC)", "American River College (ARC)"]


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



