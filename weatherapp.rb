require 'sinatra/base'
require 'sinatra/flash'
require './weather.rb'

class WeatherApp < Sinatra::Base
	enable :sessions
	register Sinatra::Flash

	get '/' do
		erb :index	
	end

	get '/new' do
		erb :new
	end

	post '/new' do
		if params[:city] && params[:state] == ""
			redirect '/failure'
		else
			city = params[:city]
			state = params[:state]
		end
		@forecast = Weather.new(city, state)
		@forecast.ping_api
		@forecast.parsing
		@forecast.kelvin_to_celsius
		@forecast.defining_variables
		session[:forecast] = @forecast.variables_to_array
		redirect '/show'
	end

	get '/show' do
		erb :show
	end

	get '/failure' do
		erb :failure
	end
end
