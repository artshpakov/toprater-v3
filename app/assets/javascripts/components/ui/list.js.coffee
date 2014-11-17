$ ->
  objectsList = ->
    @attributes
      el: "[objects-list]"

    @showAlternatives = (data) ->
      @$node.append($(data))
      @trigger document, "pageUpdated"

    @after "initialize", ->
      @on document, "objectsLoaded", (event, data) ->
        @showAlternatives data.list

      # @on "errorLoadingObjects", (e, data) ->
      #   alert "fail!"
      #   return

  Toprater.ObjectsList = flight.component(objectsList)
  Toprater.ObjectsList.attachTo "[objects-list]"
