router = ->
  @attributes
    route: ""

  @alternativesList = ->
    @trigger document, "toAlternatives", url: @attr.route

  @card = ->
    @trigger document, "toCard", url: @attr.route


  @encode = (criteria, filters) ->
    paramsPath = ""

    if criteria?.length
      paramsPath += "/criteria/" + criteria.join(",")

    if filters?.length
      paramsPath += "/filters"
      paramsPath += filterToUrl(filter.name, filter.value) for filter in filters

    paramsPath


  @buildPath = (params={}) ->
    params.criteria = _.pluck(params.criteria, 'name')
    "/objects#{ @encode params.criteria, params.filters }"

  @buildUrl = (params) ->
    "/#{ params.lang }/#{ params.sphere }" + @buildPath(params)


  @after 'initialize', ->

    routes =
      "/en/:sphere":
        "/objects/(criteria|filters).*": _.bind @alternativesList, @
        "/objects/:object/?.*": _.bind @card, @
        "/objects.*": _.bind @alternativesList, @

    router = Router routes

    router.configure
      html5history: true
      run_handler_in_init: false
    router.init()

    @on "loadMore", (event, params) ->
      @trigger document, "moreAlternatives", url: @attr.route

    @on "stateUpdated", (event, params) ->
      @attr.route = @buildUrl params
      router.setRoute @attr.route

    @on "cardClicked", (event, params) ->
      @attr.route = params.url
      router.setRoute @attr.route

    @on "backClicked", (event, params) ->
      @attr.route = params.url
      router.setRoute @attr.route


Toprater.Router = flight.component router
