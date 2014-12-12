appState = ->
  @attributes
    criteria: []
    filters: []
    sphere = ""
    lang = ""

  @buildPath = ->
    "/objects#{ @encode _.pluck(@getPicked(), "name"), @attr.filters}"

  @buildUrl = ->
    "/#{ @attr.lang }/#{ @attr.sphere }" + @buildPath()

  timeout = 0
  @getAlternatives = ->
    clearTimeout timeout
    timeout = setTimeout(
      =>
        clearTimeout timeout
        $.ajax(
          url: @buildUrl()
          method: "GET"
        )
        .fail( (data) =>
          @trigger "errorLoadingObjects", data
        )
        .done( (data) =>
          @trigger "objectsLoaded", objects: data
          @trigger "pageUpdated"
        )
      , 1000)


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

  @alternativesList = ->
    @getAlternatives()


  @after "initialize", ->
    @attr.criteria  = toprater.criteria
    @attr.filters   = toprater.state.filters
    @attr.sphere    = toprater.state.sphere
    @attr.lang      = toprater.state.locale
    @setPicked toprater.state.criteria

    routes =
      "/en/hotels":
        "/objects.*": _.bind(@alternativesList, @)

    router = Router routes
    router.configure
      html5history: true
      run_handler_in_init: false

    router.init()

    @on "cartReady", ->
      @trigger "criteriaUpdated", criteria: @getPicked()

    @on "criterionToggled", (event, data) ->
      @togglePicked data.name
      @trigger "criteriaUpdated", criteria: @getPicked()
      
      router.setRoute @buildUrl()


Toprater.AppState = flight.component appState, withParams
Toprater.AppState.attachTo document
