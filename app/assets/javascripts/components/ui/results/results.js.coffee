result = ->

  @showAlternatives = (event, data) ->
    @$node.html($(data.objects))
    Toprater.Card.attachTo "[role=card]"
    Toprater.Reviews.attachTo "[role=reviews]"
    Toprater.PricesCalendar.attachTo "[role=prices-calendar]"
    @trigger "pageUpdated"

  @handleError = (event, data) ->
    console.log data

  @after "initialize", ->
    @on document, "objectsLoaded", @showAlternatives
    @on document, "errorLoadingObjects", @handleError

Toprater.Result = flight.component(result)
