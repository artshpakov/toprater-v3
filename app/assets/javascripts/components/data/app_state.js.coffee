appState = ->
  @attributes
    criteria: []
    filters: []
    sphere: ""
    lang: ""


  @togglePicked = (criteria) ->
    criteria = [criteria] unless _.isArray criteria
    for criterion in criteria
      mapped = _.find(@attr.criteria, name: criterion)
      mapped?.picked = !mapped.picked

  @setPicked = (pickedCriteria) ->
    pickedCriteria = [pickedCriteria] unless _.isArray pickedCriteria
    _.find(@attr.criteria, name: criterion)?.picked = true for criterion in pickedCriteria

  @getPicked = ->
    _.where @attr.criteria, picked: true


  @setFilters = (filters) ->
    keys = Object.keys(filters)
    mappedFilters = []
    for key in keys
      mappedFilters.push { name: key, value: filters[key] }
    @attr.filters = mappedFilters


  @after "initialize", ->
    @attr.criteria  = toprater.criteria
    @attr.filters   = toprater.state.filters if toprater.state.filters?
    @attr.sphere    = toprater.state.sphere
    @attr.lang      = toprater.state.locale
    @setPicked toprater.state.criteria
    @setFilters toprater.state.filters if toprater.state.filters?

    to_params = =>
      criteria: @getPicked()
      filters: @attr.filters
      sphere: @attr.sphere
      lang: @attr.lang

    @trigger "stateUpdated", to_params()

    @on "filtersChanged", (event, data) ->
      filter = _.find(@attr.filters, name: data.name)
      if filter?
        filter.value = data.value
        val = filter
      else
        @attr.filters.push data
        val = data
      @trigger "#{data.name}Updated", val
      @trigger "stateUpdated", to_params()

    @on "filtersReset", ->
      @attr.filters = []
      @trigger "stateUpdated", to_params()

    @on "criterionToggled", (event, criterion) ->
      @togglePicked criterion.name
      @trigger "stateUpdated", to_params()
      @trigger document, "criteriaUpdated", criteria: @getPicked()



Toprater.AppState = flight.component appState
