$(document).ready(function(){
  $('#search').click(function(){
    if (document.getElementById("current_location").checked == true) {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position){
          get_weather(position.coords.latitude, position.coords.longitude);
        });
      }
      else
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
    else if ($('.city').val() != '')
      get_weather('', '', $('.city').val());
  });
});

function get_weather(lat, long, city = '') {
  $.ajax({
    url: '/',
    type: 'GET',
    data: {lat: lat, long: long, city: city}
  });
}
