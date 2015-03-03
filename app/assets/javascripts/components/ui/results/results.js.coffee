result = ->

  @showAlternatives = (event, data) ->
    @$node.html($(data.objects))
    Toprater.Card.attachTo "[role=card]"
    Toprater.Reviews.attachTo "[role=reviews]"
    Toprater.PricesCalendar.attachTo "[role=prices-calendar]"
    Toprater.LoadMore.attachTo "[role=load-more]"
    @trigger "pageUpdated"

  @addAlternatives = (event, data) ->
    @$node.append($(data.objects))
    Toprater.Card.attachTo "[role=card]"


  @handleError = (event, data) ->
    console.log data

  @after "initialize", ->
    @on document, "objectsLoaded", @showAlternatives
    @on document, "moreObjectsLoaded", @addAlternatives
    @on document, "errorLoadingObjects", @handleError

Toprater.Result = flight.component(result)
