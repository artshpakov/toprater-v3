withUrl = ->
    
  @encode = (criteria, filters) ->
    paramsPath = ""
    if criteria?.length
      paramsPath += "/criteria/" + criteria.join(",")
    if filters?.length
      paramsPath += "/filters"
      paramsPath += Toprater.filterToUrl(filter.name, filter.value) for filter in filters
    paramsPath


  @buildPath = (params={}) ->
    params.criteria = _.pluck(params.criteria, 'name')
    "/objects#{ @encode params.criteria, params.filters }"

  @buildUrl = (params) ->
    "/#{ params.lang }/#{ params.sphere }" + @buildPath(params)



Toprater.WithUrlMixin = withUrl
