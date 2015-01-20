criterion = ->
  @attributes
    name: ''
    label: ''
    picked: false

  @reload = ->
    Toprater.Criterion.attachTo "[role=criterion]"

  @toggleCriterion = (event) ->
    event.stopPropagation()
    @attr.picked = !@attr.picked
    @trigger "criterionToggled", @attr
    @$node.toggleClass "picked"

  @after "initialize", ->
    @$node.addClass "picked" if @attr.picked
    @attr.name = @$node.attr("data-name")
    @attr.label = @$node.attr("data-label")

    @on "click", @toggleCriterion
    @on document, "pageUpdated", @reload
    @on document, "stateUpdated", @reload
    @on document, "criteriaUpdated", @reload


Toprater.Criterion = flight.component(criterion)
