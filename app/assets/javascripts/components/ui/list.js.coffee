objectsList = ->

  @showAlternatives = (data) ->
    @$node.html($(data))
    @trigger document, "pageUpdated"


  @after "initialize", ->
    @on document, "objectsLoaded", (event, data) ->
      @showAlternatives data.objects
      
    @on "errorLoadingObjects", (event, data) ->
      alert data


Toprater.ObjectsList = flight.component(objectsList)
Toprater.ObjectsList.attachTo "[role=objects-list]"
