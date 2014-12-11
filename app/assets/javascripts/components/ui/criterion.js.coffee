criterion = ->
  @attributes
    name: ''
    label: ''
    picked: false

  @toggleCriterion = (event) ->
    event.stopPropagation()
    @attr.picked = !@attr.picked
    @trigger "criterionToggled", name: @attr.name

  @after "initialize", ->
    @attr.name = @$node.attr("data-name")
    @attr.label = @$node.attr("data-label")

    @on "click", @toggleCriterion

    @on document, "pageUpdated", ->
      Toprater.Criterion.attachTo "[role=criterion]"

Toprater.Criterion = flight.component(criterion)
Toprater.Criterion.attachTo "[role=criterion]"
