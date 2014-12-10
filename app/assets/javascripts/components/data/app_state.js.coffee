appState = ->
  @attributes
    criteria: []
    filters: []
    sphere = ""
    lang = ""

  @buildPath = ->
    "/objects" + @encode _.pluck(@getPicked(), "name"), @attr.filters

  @buildUrl = ->
    "/#{ @attr.lang }/#{ @attr.sphere }" + @buildPath()

  @getAlternatives = ->
    self = @
    $.ajax(
      url: self.buildUrl()
      method: "GET"
    )
    .fail( (data) ->
      self.trigger "errorLoadingObjects", data
    )
    .done( (data) ->
      self.trigger "objectsLoaded", objects: data
      )

  @setPicked = (pickedCriteria) ->
    if not _.isArray pickedCriteria
      pickedCriteria = [pickedCriteria]

    _.each pickedCriteria, (criterion) =>
      ca = _.where @attr.criteria, name: criterion
      _.each ca, (cr) ->
        cr.picked = true

  @getPicked = ->
    _.where @attr.criteria, picked: true

  @alternativesList = ->
    @getAlternatives()


  @after "initialize", ->
    @attr.sphere = document.location.pathname.split("/")[2]
    @attr.lang = document.location.pathname.split("/")[1]

    if toprater.criteria?
      @attr.criteria = toprater.criteria

    if toprater.filters?
      @attr.filters = @decode(window.location.pathname).filters

    if toprater.pickedCriteria?
      @setPicked(toprater.pickedCriteria.split(","))
      # @trigger "criteriaUpdated", criteria: @getPicked()

    routes = {
      "/en/hotels": {
        "/objects/.*": _.bind(@alternativesList, @)
      }
    }

    router = Router routes
    router.configure
      html5history: true
      run_handler_in_init: false

    router.init()

    @on "cartReady", ->
      @trigger "criteriaUpdated", criteria: @getPicked()

    @on "criterionToggled", (event, data) ->
      @setPicked data.name

      @trigger "criteriaUpdated", criteria: @getPicked()
      
      History.pushState @buildUrl()
      History.setHash @buildUrl()


Toprater.AppState = flight.component appState, withParams
Toprater.AppState.attachTo document
