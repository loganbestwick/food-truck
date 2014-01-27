$(document).ready( function(){

	function initialize() {
		var mapOptions = {
			zoom: 13,
			center: new google.maps.LatLng(37.772609, -122.442457)
		};

		var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	}

	google.maps.event.addDomListener(window, 'load', initialize);

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
			console.log(data);
		})
	});


})