objectsList = ->

  @showAlternatives = (data) ->
    @$node.html($(data))


  @after "initialize", ->
    @on document, "objectsLoaded", (event, data) ->
      @showAlternatives data.objects
      
    @on "errorLoadingObjects", (event, data) ->
      console.log data


Toprater.ObjectsList = flight.component(objectsList)
Toprater.ObjectsList.attachTo "[role=objects-list]"
