objectsList = ->

  @showAlternatives = (data) ->
    @$node.html($(data))


  @after "initialize", ->
    @on "objectsLoaded", (event, data) ->
      @showAlternatives data.objects
      
    @on "errorLoadingObjects", (event, data) ->
      #TODO: Error handling
      console.log data


Toprater.ObjectsList = flight.component(objectsList)
Toprater.ObjectsList.attachTo "[role=objects-list]"
