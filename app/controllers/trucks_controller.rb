##TODO
##Hide google maps API key
##Give maps rounded edges
##Convert .erb files to .haml
##Trucks the proper model name?



class TrucksController < ApplicationController

	def index
	end

	def create
		search_location = get_longitude_latitude(params['truck']['search_address'])
		trucks_array = HTTParty.get('https://data.sfgov.org/resource/rqzj-sfat.json')
		clean_truck_data(trucks_array)
		find_trucks(trucks_array, search_location, params['truck']['radius'])
		render 'index'
	end

	def find_trucks(trucks_array, search_location, range)
		trucks_in_range = []
		trucks_array.each do |truck_data|
			ap truck_data
			distance = GeoDistance::Haversine.geo_distance(search_location[:latitude], search_location[:longitude], 
				truck_data["latitude"], truck_data["longitude"] ).to_miles
			if distance.miles <= range.to_f
				p distance.miles
				trucks_in_range << truck_data
			end
		end
		trucks_in_range
	end

	def get_longitude_latitude(address)
    google_map_results = Geocoder.search(address)
    latitude = google_map_results[0].data["geometry"]["location"]["lat"]
    longitude = google_map_results[0].data["geometry"]["location"]["lng"]
    {:latitude => latitude, :longitude => longitude}
  end

  def clean_truck_data(trucks_array)
  	p trucks_array.count
  	trucks_array.delete_if {|truck| truck["latitude"] == nil}
  	p trucks_array.count
  end

end