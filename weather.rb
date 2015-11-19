require 'open-uri'
require 'json'

puts "City:"
city = gets.chomp
puts 'State/country:'
state = gets.chomp
if city.empty? || state.empty?
	puts "Please, provide city name and state/country."
end

base_url = "http://api.openweathermap.org/data/2.5/weather?q="
api_id = "&APPID=aade92db2619aca3f567b1ac542128b5"
location = "#{city},#{state}"
full_url = "#{base_url}#{location}#{api_id}"

response = open(full_url).read
parsed = JSON.parse(response)

if parsed['cod'] == 400
	puts "not found, try again."
	city_and_state
end 

temp = parsed['main']['temp']
station = parsed['name'] 
lan, lat = parsed['coord']['lon'], parsed['coord']['lat']
pressure = parsed['main']['pressure']
humidity = parsed['main']['humidity']
wind_speed = parsed['wind']['speed']
weather_description = parsed['weather'].first['description']
cloudiness = parsed['clouds']['all'] 

def kelvin_to_celsius kelvin
	c = kelvin - 273.15
end
temp_in_c = kelvin_to_celsius(temp).round(1)

puts "This is data colected in #{station} station. Coordinates: #{lan}, #{lat}"
puts "Description: #{weather_description}"
puts "Temperature: #{temp_in_c} C°"
puts "Humidity: #{humidity}%"
puts "Wind speed: #{wind_speed} m/s"
puts "Cloudiness: #{cloudiness}%"
