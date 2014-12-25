router = ->


  

  # timeout = 0
  @getAlternatives = ->
    $.ajax(
      url: @route
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingObjects", data
    )
    .done( (data) =>
      console.log @
      @trigger "objectsLoaded", objects: data
      @trigger "pageUpdated"
    )

    # clearTimeout timeout
    # timeout = setTimeout(
    #   =>
    #     clearTimeout timeout
    #     $.ajax(
    #       url: @route
    #       method: "GET"
    #     )
    #     .fail( (data) =>
    #       @trigger "errorLoadingObjects", data
    #     )
    #     .done( (data) =>
    #       console.log @
    #       @trigger "objectsLoaded", objects: data
    #       @trigger "pageUpdated"
    #     )
    #   , 1000)


  routes =
    "/en/:sphere":
      "/objects.*": _.bind(@getAlternatives, @)


  encode = (criteria, filters) ->
    paramsPath = ""

    if criteria?.length
      paramsPath += "/criteria/" + criteria.join(",")

    if filters?.length
      paramsPath += "/filters"
      paramsPath += "/#{ filter.name }/#{ filter.value }" for filter in filters

    paramsPath


  @buildPath = (params={}) ->
    params.criteria = _.pluck(params.criteria, 'name')
    # "/objects#{ encode _.pluck(@getPicked(), "name"), @attr.filters}"
    "/objects#{ encode params.criteria, params.filters }"

  @buildUrl = (params) =>
    "/#{ params.lang }/#{ params.sphere }" + @buildPath(params)


  @after 'initialize', ->

    router = Router routes
    router.configure
      html5history: true
      run_handler_in_init: false
    router.init()

    @on "stateUpdated", (event, params) =>
      @route = @buildUrl params
      router.setRoute @route



Toprater.Router = flight.component router
Toprater.Router.attachTo document
