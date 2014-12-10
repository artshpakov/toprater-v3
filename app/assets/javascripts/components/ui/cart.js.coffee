cart = ->
  @attributes
    template: ""

  # @removeCriterion = (event) ->
  #   debugger
  #   event.stopPropagation()
  #   for x in [1,2,3,4,5]
  #     console.log x
  #   console.log event
    
    # @trigger "criterionToggled", { name: @attr.name }

  @after "initialize", ->
    @attr.template = @$node.find("[type='text/template']").html()

    @on document, "criteriaUpdated", (event, data) ->
      @$node.html @renderTemplate @attr.template, criteria: data.criteria

      # console.log @$node.find "a"
      # @on @$node.find "a", "click", @removeCriterion

    @trigger "cartReady"


Toprater.Cart = flight.component cart, withHogan
Toprater.Cart.attachTo "[role='cart']"
