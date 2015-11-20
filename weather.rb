require 'open-uri'
require 'json'

class Weather
	attr_accessor :city, :state
	def initialize city, state
		@city = city
		@state = state
	end

	def ping_api
		base_url = "http://api.openweathermap.org/data/2.5/weather?q="
		api_id = "&APPID=aade92db2619aca3f567b1ac542128b5"
		location = "#{@city},#{@state}"
		@full_url = "#{base_url}#{location}#{api_id}"
	end

	def parsing
		response = open(@full_url).read
		@parsed = JSON.parse(response)
	end

	def kelvin_to_celsius
		@temp_in_c = (@parsed['main']['temp'] - 273.15).round(1)
	end

	def defining_variables
		@station = @parsed['name'] 
		# @lan, @lat = @parsed['coord']['lon'], @parsed['coord']['lat']
		# @pressure = @parsed['main']['pressure']
		# @humidity = @parsed['main']['humidity']
		# @wind_speed = @parsed['wind']['speed']
		# @weather_description = @parsed['weather'].first['description']
		# @cloudiness = @parsed['clouds']['all'] 	
	end

	# def printing_data
	# 	puts "This is data colected in #{@station} station. Coordinates: #{@lan}, #{@lat}"
	# 	puts "Description: #{@weather_description}"
	# 	puts "Temperature: #{@temp_in_c} C°"
	# 	puts "Humidity: #{@humidity}%"
	# 	puts "Wind speed: #{@wind_speed} m/s"
	# 	puts "Cloudiness: #{@cloudiness}%"
	# end
end

# malo_vreme = Weather.new('Belgrade','Serbia')
# .ping_api
# .parsing
# .kelvin_to_celsius
# .defining_variables
# .printing_data
