dataFindCompany = ->
  @attributes
    criteria: []
    filters:
      segm: ""


  @togglePicked = (criteria) ->
    criteria = [criteria] unless _.isArray criteria
    for criterion in criteria
      mapped = _.find(@attr.criteria, name: criterion)
      if mapped?
        mapped.picked = !mapped.picked
      else
        @attr.criteria.push { name: criterion, picked: true }

    if _.filter(@attr.criteria, (criterion) -> criterion.picked).length > 0
      @trigger @$node, "criteriaChanged", set: true
    else
      @trigger @$node, "criteriaChanged", set: false


  @after "initialize", ->
    @on @$node, "criterionToggled", (event, criterion) ->
      event.stopPropagation()
      @togglePicked criterion.name

    @on @$node, "industryToggled", (event, data) ->
      event.stopPropagation()
      @attr.filters.segm = data.industry

      @trigger @$node, "filtersChanged", set: true

Toprater.DataFindMechanic = flight.component dataFindCompany
