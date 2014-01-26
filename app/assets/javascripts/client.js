$(document).ready( function(){

	function initialize() {
		var mapOptions = {
			zoom: 13,
			center: new google.maps.LatLng(37.772609, -122.442457)
		};

		var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	}

	google.maps.event.addDomListener(window, 'load', initialize);


})