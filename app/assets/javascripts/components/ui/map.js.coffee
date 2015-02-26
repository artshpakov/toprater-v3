mapCanvas = ->

  DEFAULT_ZOOM = 15

  init = ->

    locations = _.map $('[role=map-location]'), (el) ->
      [$(el).data('title'), $(el).data('geolat'), $(el).data('geolng')]
    centerLat = _.reduce(locations, ((memo, place) ->
      memo + place[1]
    ), 0) / locations.length
    centerLng = _.reduce(locations, ((memo, place) ->
      memo + place[2]
    ), 0) / locations.length

    map = new google.maps.Map $(@$node).get(0),
      zoom: ($('[role=map-location]').eq(0).data('zoom') || DEFAULT_ZOOM)
      center: new google.maps.LatLng(centerLat, centerLng)
      mapTypeId: google.maps.MapTypeId.ROADMAP

    infowindow  = new google.maps.InfoWindow()
    bounds      = new google.maps.LatLngBounds()

    _.each locations, (place) ->
      marker = new google.maps.Marker
        map: map
        position: new google.maps.LatLng(place[1], place[2])
        title: place[0]
      bounds.extend marker.position
      # google.maps.event.addListener(marker, 'click', (function(marker, i) {
      #   return function() {
      #     infowindow.setContent(locations[i][0]);
      #     infowindow.open(map, marker);
      #   }
      # })(marker, i));

    map.fitBounds bounds if locations.length>1


  @after 'initialize', ->
    init.call @
    @on document, "pageUpdated", init


Toprater.MapCanvas = flight.component(mapCanvas)
