dataFindCompany = ->
  @attributes
    criteria: []
    filters:
      name: "segm"
      value: ""


  @encode = (criteria, filters) ->
    paramsPath = ""

    if criteria?.length
      paramsPath += "/criteria/" + _.pluck(criteria, "name").join(",")

    if filters?.length
      paramsPath += "/filters"
      paramsPath += Toprater.filterToUrl(filter.name, filter.value) for filter in filters

    paramsPath

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


  @getResults = ->
    path = @encode _.filter(@attr.criteria, (elem) -> elem.picked == true), [@attr.filters]
    url =  "#{ window.location.href }#{ path }?find_employer=true"

    $.ajax(
      url: url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingGameResults", data
    )
    .done( (data) =>
      @trigger "gameResultsLoaded", { result: data, path: path }
    )


  @after "initialize", ->
    @on @$node, "criterionToggled", (event, criterion) ->
      event.stopPropagation()
      @togglePicked criterion.name

    @on @$node, "industryToggled", (event, data) ->
      event.stopPropagation()
      @attr.filters.value = data.industry

      @trigger @$node, "filtersChanged", set: true

    @on @$node, "uiResultsReq", @getResults

    @on @$node, "restartFindMechanic", ->
      @attr.criteria = []
      @attr.filters.value = ""

Toprater.DataFindMechanic = flight.component dataFindCompany
