card = ->

  @showAlternative = (event) ->
    event.stopPropagation()
    event.preventDefault()
    @trigger document, "cardClicked", url: @$node.find("[role=card-link]").attr("href")

  @showAlternatives = (event, data) ->
    event.stopPropagation()
    event.preventDefault()
    @trigger document, "backClicked", url: @$node.find("[role=back-link]").attr("href")    


  @after "initialize", ->
    @on @$node.find("[role=card-link]"), "click", @showAlternative

    @on @$node.find("[role=back-link] a"), "click", @showAlternatives


Toprater.Card = flight.component card
