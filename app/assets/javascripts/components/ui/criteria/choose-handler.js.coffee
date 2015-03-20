chooseHandler = ->
  @attributes
    criteria: ->
      new Array()
    sphere: ->
      new String()

  @togglePicked = (criteria) ->
    # TODO: refactor and create mixin
    criteria = [criteria] unless _.isArray criteria
    for criterion in criteria
      mapped = _.find(@attr.criteria, name: criterion.name)
      if mapped?
        mapped.picked = !mapped.picked
      else
        @attr.criteria.push { name: criterion.name, picked: true }


    if _.filter(@attr.criteria, (criterion) -> criterion.picked).length
      @$node.find("[role=show-results]").addClass "active"
    else
      @$node.find("[role=show-results]").removeClass "active"

  @after "initialize", ->
    @attr.sphere = @$node.attr "data-sphere"
    @on @$node.find("[role=defer-criterion]"), "uiCriterionToggled", (event, criterion) ->
      event.stopPropagation()
      @togglePicked criterion

    @on @$node.find("[role=show-results]"), "click", (event) ->
      event.stopPropagation()
      event.preventDefault()
      # console.log @attr.criteria
      if _.filter(@attr.criteria, (criterion) -> criterion.picked).length
        @trigger document, "uiCriterionToggled", { criteria: @attr.criteria, sphere: @attr.sphere }


Toprater.CriteriaChooseHandler = flight.component chooseHandler
