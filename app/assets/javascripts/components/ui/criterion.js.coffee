criterion = ->
  @attributes
    name: ''
    label: ''
    selected: false

  @toggleCriterion = (event) ->
    event.stopPropagation()
    @attr.selected = !@attr.selected
    @trigger "criterionToggled", { name: @attr.name, label: @attr.label }

  @after "initialize", ->
    @attr.name = @$node.attr("data-name")
    @attr.label = @$node.attr("data-label")

    @on "click", @toggleCriterion

    @on document, "pageUpdated", ->
      Toprater.Criterion.attachTo "[role=criterion]"

Toprater.Criterion = flight.component(criterion)
Toprater.Criterion.attachTo "[role=criterion]"
