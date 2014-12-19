cart = ->
  @attributes
    template: ""

  @after "initialize", ->
    @attr.template = @$node.find("[type='text/template']").html()

    @on document, "criteriaUpdated", (event, data) ->
      @$node.html @renderTemplate @attr.template, criteria: data.criteria

    @trigger "cartReady"

Toprater.Cart = flight.component cart, withHogan
Toprater.Cart.attachTo "[role='cart']"
