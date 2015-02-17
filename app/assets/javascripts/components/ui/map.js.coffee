mapCanvas = ->

  init = ->
    objectPosition = new google.maps.LatLng @$node.data('geolat'), @$node.data('geolng')

    mapOptions =
      center: objectPosition
      zoom: @$node.data('zoom')
      mapTypeId: google.maps.MapTypeId.ROADMAP
      scrollwheel: false

    map = new google.maps.Map @$node.get(0), mapOptions
    marker = new google.maps.Marker
      position: objectPosition
      map: map
      title: @$node.data('title')

  @after 'initialize', init


Toprater.MapCanvas = flight.component(mapCanvas)
