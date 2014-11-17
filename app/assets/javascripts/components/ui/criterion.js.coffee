$ ->
  criterion = ->
    @attributes
      name: ''
      selected: false

    @selectCriterion = (e) ->
      # alert(@attr.name)
      e.stopPropagation()
      @attr.selected = true
      @trigger "criterionSelected", name: @attr.name

    @after "initialize", ->
      @attr.name = @$node.attr("data-name")

      @on "click", @selectCriterion

      @on document, "pageUpdated", ->
        Toprater.Criterion.attachTo "[criterion]"

  Toprater.Criterion = flight.component(criterion)
  Toprater.Criterion.attachTo "[criterion]"
