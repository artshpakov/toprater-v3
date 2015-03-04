dataResults = ->
  @attributes
    offset: 0

  @load = (url, sendEvent) ->
    $.ajax(
      url: url
      data:
        offset: @attr.offset
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingObjects", data
    )
    .done( (data) =>
      @trigger sendEvent, objects: data
      @trigger document, "pageUpdated"
    )

  @getAlternatives = (event, route) ->
    @attr.offset = 0
    @load(route.url, 'objectsLoaded')

  @moreAlternatives = (event, route) ->
    @attr.offset += 5
    @load(route.url, 'moreObjectsLoaded')

  @after "initialize", ->
    @on document, "toAlternatives", @getAlternatives
    @on document, "moreAlternatives", @moreAlternatives


Toprater.DataResults = flight.component(dataResults)
