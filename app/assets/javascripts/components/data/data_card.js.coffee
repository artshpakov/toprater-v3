dataCard = ->

  @reload = ->
    console.log "DATA RELOAD"
    Toprater.DataCard.attachTo "[role=card]"

  @getCard = (params) ->
    $.ajax(
      url: params.url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingCard", data
    )
    .done( (data) =>
      # @trigger "objectsLoaded", objects: data
      @trigger document, "pageUpdated"
    )

  @after "initialize", ->
    console.log "DATA CARD"
    @on document, "pageUpdated", @reload
    @on document, "toCard", @getCard


Toprater.DataCard = flight.component dataCard
