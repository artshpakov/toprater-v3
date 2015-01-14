results = ->

  @getAlternatives = (event, route) ->
    $.ajax(
      url: route.url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingObjects", data
    )
    .done( (data) =>
      @trigger "objectsLoaded", objects: data
      @trigger document, "pageUpdated"
    )
    # clearTimeout timeout
    # timeout = setTimeout(
    #   =>
    #     clearTimeout timeout
    #     $.ajax(
    #       url: @route
    #       method: "GET"
    #     )
    #     .fail( (data) =>
    #       @trigger "errorLoadingObjects", data
    #     )
    #     .done( (data) =>
    #       console.log @
    #       @trigger "objectsLoaded", objects: data
    #       @trigger "pageUpdated"
    #     )
    #   , 1000)

  @after "initialize", ->
    @on document, "toAlternatives", @getAlternatives


Toprater.Results = flight.component(results)
