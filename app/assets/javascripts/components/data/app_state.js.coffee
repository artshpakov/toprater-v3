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

    @trigger "dataStateUpdated", to_params()
    @trigger "dataPageLoaded", to_params()

    @on "uiFiltersChanged", (event, data) ->
      filter = _.find(@attr.filters, name: data.filterName)
      if filter?
        if Toprater.isMultiFilter(data.filterName)
          filter.value.push data.value
        else
          filter.value = data.value
        val = filter
      else
        if Toprater.isMultiFilter(data.filterName)
          data.value = [data.value]
        @attr.filters.push data
        val = data
      @trigger "#{data.filterName}Updated", val
      @trigger "dataStateUpdated", to_params()

    @on "uiFilterReset", (event, data) ->
      removeFilter = (filter) =>
        @attr.filters = _.reject(@attr.filters, (f) =>
          f.name == filter
        )

      unless Toprater.isMultiFilter(data.filter)
        removeFilter data.filter
      else
        filter = _.find(@attr.filters, name: data.filter)
        filter.value.splice filter.value.indexOf(data.value), 1
        if filter.value.length == 0
          removeFilter data.filter

      @trigger "dataStateUpdated", to_params()

    @on "uiFiltersReset", ->
      @attr.filters = []
      @trigger "dataStateUpdated", to_params()

    @on "uiCriterionToggled", (event, criterion) ->
      @togglePicked criterion.name
      @trigger "dataStateUpdated", to_params()



Toprater.AppState = flight.component appState
