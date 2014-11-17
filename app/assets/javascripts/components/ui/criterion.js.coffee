$ ->
  Toprater.Criterion = flight.component ->
    @attributes
      name: ''

    @selectCriterion = (e) ->
      e.stopPropagation()
      @trigger "criterionSelected", name: @attr.name

    @after "initialize", ->
      @$node.hide()
      @attr.name = @$node.attr("data-name")

      @on "click", @selectCriterion


  Toprater.Criterion.attachTo "[criterion]"
