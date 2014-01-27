$(document).ready( function(){

	var marker;

	function initialize() {
		var mapOptions = {
			zoom: 13,
			center: new google.maps.LatLng(37.772609, -122.442457)
		};

		var map = new google.maps.Map($("#map-canvas")[0], mapOptions);

		$("#search_button").on('click', function(e){
			e.preventDefault();
			var address = $('#truck_search_address').val();
			var radius = $("input:radio:checked").val();
			$.ajax({
				url: "/trucks",
				type: "post",
				data: {"search_address" : address, "radius" : radius},
				dataType: 'json'
			}).done(function(data){
				addMarker(data);
			})
		});

		function addMarker(json) {
			if (marker) {
				marker.setMap(null);
			}
			for(i = 0; i < json.length; i++) {
				var latLng = new google.maps.LatLng(json[i]["latitude"], json[i]["longitude"]);
				var market = new google.maps.Marker({
					position: latLng,
					map: map
				});
			}
		}

	}

	google.maps.event.addDomListener(window, 'load', initialize);

})