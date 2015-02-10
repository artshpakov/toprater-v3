dataCard = ->

  @after "initialize", ->
    @on document, "toCard", @getCard


Toprater.DataCard = flight.component dataCard
