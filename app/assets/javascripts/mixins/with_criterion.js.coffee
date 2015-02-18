withCriterion = ->
  @attributes
    name: ""
    label: ""
    picked: false

  @toggleCriterion = (event) ->
    event.stopPropagation()
    @attr.picked = !@attr.picked
    @$node.toggleClass "picked"


  @after "initialize", ->
    @$node.addClass "picked" if @attr.picked
    @attr.name = @$node.attr("data-name")
    @attr.label = @$node.attr("data-label")

    @on "click", @toggleCriterion


Toprater.WithCriterionMixin = withCriterion
