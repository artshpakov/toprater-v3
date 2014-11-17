$ ->
  objectsList = ->
    @attributes
      el: "[objects-list]"

    @showObjects = (e, data) ->
      alert "loaded!"

    @after "initialize", ->
      @on "objectsLoaded", ->
        console.log "loaded"
        @showObjects
        
      @on "errorLoadingObjects", (e, data) ->
        alert "fail!"

  Toprater.ObjectsList = flight.component(objectsList)
  Toprater.ObjectsList.attachTo "[objects-list]"
