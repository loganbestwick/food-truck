$(document).ready( function(){
	console.log("ready");

	function initialize() {
		var mapOptions = {
			zoom: 8,
			center: new google.maps.LatLng(37.783, 122.416)
		};

		var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	}

	google.maps.event.addDomListener(window, 'load', initialize);


})