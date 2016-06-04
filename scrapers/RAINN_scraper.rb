require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'watir-webdriver'

browser = Watir::Browser.new

browser.goto('http://centers.rainn.org/details.cfm/rape-crisis-center-details/2nd-Chance-Anniston-AL_100700')
sleep(rand(1..4))
doc = Nokogiri::HTML.parse(browser.html)
# service_provider = ServiceProvider.new
p doc.xpath('//h3').children.text
p "***" * 30
p doc.xpath("//address").first.text
p "***" * 30
doc.xpath("//small").each {|small| p small.text}


# # puts b.form(:name, "center_search").when_present.text

# rainn_agent = Mechanize.new

# page = Mechanize::Page.new(nil, {'content-type' => 'text/hmtl'}, html, nil, rainn_agent)

# # def select_option(form, field_value, text)
# #   value = nil
# #   form.field_with(:value => field_value).options.each{|o| value = o if o.text == text }

# #   raise ArgumentError, "No option with text '#{text}' in field '#{field_value}'" unless value
# #   form.field_with(:value => field_value).value = value
# # end

# form = page.forms.first
# form.field_with(:name => 'state') do |field|
# field.value = 'AL'
# end.submit

# # .option_with(:value => 'AL')


# # b.goto(request2)
# # response2 = mechanize.urlopen(request2)

# # print response2.geturl



# # # form do |f|
# # #   select_option(f, 'AL', 'Alabama')
# # # end.submit

# # select_list = form.field_with(:name => 'state')
# # # # p select_list.option_with(:value => 'Alabama')
# # select_list(:value => 'AL').click


# # # puts page.uri

# # # form.field_with(:name => 'state').options[0].select
