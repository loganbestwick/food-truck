##TODO
##Hide google maps API key
##Give maps rounded edges
##Convert .erb files to .haml
##Trucks the proper model name?



class TrucksController < ApplicationController

	def index
	end

	def create
		search_location = Geokit::Geocoders::GoogleGeocoder.geocode(params['truck']['search_address'])		
		trucks_array = HTTParty.get('https://data.sfgov.org/resource/rqzj-sfat.json')
		p "8" * 50
		ap find_trucks(trucks_array, search_location, params['truck']['radius'])
		render 'index'
	end

	def find_trucks(trucks_array, search_location, range)
		trucks_in_range = []
		trucks_array.each do |truck_data|
			ap truck_data
			truck_location = Geokit::Geocoders::GoogleGeocoder.geocode("#{truck_data['latitude']}, #{truck_data['longitude']}")
			if search_location.distance_to(truck_location) <= range.to_f
				p search_location.distance_to(truck_location)
				trucks_in_range << truck_data
			end
		end
		trucks_in_range
	end

end