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
			distance = coorDist(search_location[:latitude], search_location[:longitude], 
				truck_data["latitude"].to_f, truck_data["longitude"].to_f)
			if distance <= range.to_f
				p distance
				trucks_in_range << truck_data
			end
		end
		trucks_in_range
	end

	def coorDist(lat1, lon1, lat2, lon2)
    earthRadius = 6371 # Earth's radius in KM

    deltaLat = (lat2-lat1)
    deltaLon = (lon2-lon1)
    deltaLat = convDegRad(deltaLat)
    deltaLon = convDegRad(deltaLon)

    # Calculate square of half the chord length between latitude and longitude
    a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
        Math.cos((lat1/180 * Math::PI)) * Math.cos((lat2/180 * Math::PI)) *
        Math.sin(deltaLon/2) * Math.sin(deltaLon/2); 

    # Calculate the angular distance in radians
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    distance = earthRadius * c

  	return distance/1.60934
	end

  # convert degrees to radians
  def convDegRad(value)
  	unless value.nil? or value == 0
  		value = (value/180) * Math::PI
    end
  	return value
  end

	def get_longitude_latitude(address)
    google_map_results = Geocoder.search(address)
    latitude = google_map_results[0].data["geometry"]["location"]["lat"]
    longitude = google_map_results[0].data["geometry"]["location"]["lng"]
    {:latitude => latitude, :longitude => longitude}
  end

  def clean_truck_data(trucks_array)
  	trucks_array.delete_if {|truck| truck["latitude"] == nil}
  end

end