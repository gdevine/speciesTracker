# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class CustomMarkerBuilder extends Gmaps.Google.Builders.Marker
  create_marker: ->
    options = _.extend @marker_options(), @rich_marker_options()
    @serviceObject = new RichMarker options

  rich_marker_options: ->
    marker = document.createElement("div")
    marker.setAttribute('class', 'custom_marker_content')
    marker.innerHTML = this.args.custom_marker
    { content: marker }

  create_infowindow: ->
    return null unless _.isString @args.custom_infowindow

    boxText = document.createElement("div")
    boxText.setAttribute("class", 'custom_infowindow_content')
    boxText.innerHTML = @args.custom_infowindow
    @infowindow = new InfoBox(@infobox(boxText))

  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-140, 0)
    boxStyle:
      width: "280px"