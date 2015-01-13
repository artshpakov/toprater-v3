cart = ->
  @render = (event, data) ->
    @$node.html JST['cart'].render({criteria: data.criteria})

  @after "initialize", ->
    @on document, "criteriaUpdated", @render
    @on document, "stateUpdated", @render

Toprater.Cart = flight.component cart
