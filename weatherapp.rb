require 'sinatra/base'
require 'sinatra/flash'
require './weather.rb'

class WeatherApp < Sinatra::Base
	enable :sessions

	get '/' do
		erb :new	
	end

	get '/new' do
		erb :new
	end

	post '/new' do
		city = params[:city]
		state = params[:state]
		@forecast = Weather.new(city, state)
		@forecast.ping_api
		@forecast.parsing
		@forecast.kelvin_to_celsius
		session[:forecast] = @forecast.defining_variables
		redirect '/show'
	end

	get '/show' do
		erb :show
	end

end
