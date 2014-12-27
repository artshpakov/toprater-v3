cart = ->
  @render = (event, data) ->
    @$node.html JST['cart'].render({criteria: data.criteria})

  @after "initialize", ->
    @on document, "criteriaUpdated", @render
    @trigger "cartReady"

Toprater.Cart = flight.component cart
Toprater.Cart.attachTo "[role='cart']"
