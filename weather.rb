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
		#@lan, @lat = @parsed['coord']['lon'], @parsed['coord']['lat']
		@pressure = @parsed['main']['pressure']
		@humidity = @parsed['main']['humidity']
		@wind_speed = @parsed['wind']['speed']
		@weather_description = @parsed['weather'].first['description']
		@cloudiness = @parsed['clouds']['all']
		 	
	end

	def variables_to_array
		array = []
		array.push(@station, @temp_in_c, @weather_description, @pressure, @humidity, @wind_speed, @cloudiness)
	end
end

