withParamsCtr = ->

  @decode = (url) ->
    params = {}
    urlPartials = url.split("/")

    if _.contains urlPartials, "criteria"
      params.criteria = urlPartials[_.indexOf(urlPartials, "criteria") + 1].split(",")

    if _.contains urlPartials, "filters"
      filtersList = _.compact(urlPartials[(_.indexOf(urlPartials, "filters") + 1)..])

      params.filters = []

      for f, i in filtersList
        if i % 2 == 0
          filter =
            name: f
            value: filtersList[i+1]
          params.filters.push filter

    params

  @encode = (criteria, filters) ->
    paramsPath = ""

    if criteria? and criteria.length
      paramsPath += "/criteria/" + criteria.join(",")

    if filters? and filters.length
      paramsPath += "/filters"
      paramsPath += "/#{filter.name}/#{filter.value}" for filter in filters

    paramsPath



window.withParams = withParamsCtr
