appState = ->
  @attributes
    selectedCriteria: []
    realm = ""
    lang = ""

  @buildPath = ->
    "/objects?criteria=[" + (("#{ criterion.name }" for key, criterion of @attr.selectedCriteria).join ",") + "]"

  @buildUrl = ->
    "/#{ @attr.lang }/#{ @attr.realm }" + @buildPath()

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

  @alternativesList = ->
    @getAlternatives()

  @after "initialize", ->
    @attr.realm = document.location.pathname.split("/")[2]
    @attr.lang = document.location.pathname.split("/")[1]


    routes = {
      "/en/hotels": {
        "/objects?:param=[:value*]*": _.bind(@alternativesList, @)
      }
    }

    router = Router routes
    router.configure
      html5history: true
      run_handler_in_init: false

    router.init()

    @on "criterionToggled", (event, data) ->
      if _.contains _.pluck(@attr.selectedCriteria, "name"), data.name
        @attr.selectedCriteria = _.reject @attr.selectedCriteria, (criterion) -> criterion.name == data.name
      else
        @attr.selectedCriteria.push data

      @trigger "criteriaUpdated", criteria: @attr.selectedCriteria
      
      History.pushState @buildUrl()
      History.setHash @buildUrl()


Toprater.AppState = flight.component appState
Toprater.AppState.attachTo document
