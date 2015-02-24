dataCard = ->

  @getCard = (event, params) ->
    $.ajax(
      url: params.url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingCard", data
    )
    .done( (data) =>
      Toprater.Card.attachTo "[role=card]"
      @trigger document, "objectsLoaded", objects: data
      @trigger document, "pageUpdated"
      Toprater.MapCanvas.attachTo "[role=map-canvas]"
    )

  @after "initialize", ->
    @on document, "toCard", @getCard


Toprater.DataCard = flight.component dataCard
