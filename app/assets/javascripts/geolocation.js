
function getGPSLocation()
{
var options = {
  enableHighAccuracy: true,
  timeout: 6000,
  maximumAge: 0
};

function success(pos) {
  var crd = pos.coords;

  document.getElementById("sighting_latitude").value = crd.latitude.toFixed(6) ;
  document.getElementById("sighting_longitude").value = crd.longitude.toFixed(6) ;
  document.getElementById("sighting_altitude").value = crd.altitude.toFixed(2) ;
};

function error(err) {
  console.warn('ERROR(' + err.code + '): ' + err.message);
};

navigator.geolocation.getCurrentPosition(success, error, options);

}