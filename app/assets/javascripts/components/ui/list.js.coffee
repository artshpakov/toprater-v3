objectsList = ->

  @showAlternatives = (event, data) ->
    @$node.html($(data.objects))
    Toprater.Reviews.attachTo "[role=reviews]"
    @trigger "pageUpdated"

  @handleError = (event, data) ->
    console.log data

  @after "initialize", ->
    @on document, "objectsLoaded", @showAlternatives
    @on document, "errorLoadingObjects", @handleError

Toprater.ObjectsList = flight.component(objectsList)
Toprater.ObjectsList.attachTo "[role=objects-list]"
