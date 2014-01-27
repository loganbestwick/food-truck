class TrucksController < ApplicationController
	include GeoMethods

	def index
	end

	def new
		search_location = GeoMethods.get_longitude_latitude(params['search_address'])
		trucks_array = HTTParty.get('https://data.sfgov.org/resource/rqzj-sfat.json')
		clean_truck_data(trucks_array)
		truck_results = find_trucks(trucks_array, search_location, params['radius'])
		render :json => truck_results
	end




#Controller Specific Methods
	def find_trucks(trucks_array, search_location, range)
		trucks_in_range = []
		trucks_array.each do |truck_data|
			distance = GeoMethods.coorDist(search_location[:latitude], search_location[:longitude], 
				truck_data["latitude"].to_f, truck_data["longitude"].to_f)
			if distance <= range.to_f
				trucks_in_range << truck_data
			end
		end
		trucks_in_range
	end

  def clean_truck_data(trucks_array)
  	trucks_array.delete_if {|truck| truck["latitude"] == nil}
  end

end