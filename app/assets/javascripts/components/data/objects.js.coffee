$ ->
  objectsData =  ->
    @attributes
      selectedCriteria: []

    @getAlternatives = ->
      @get
        url: "hotels/objects?" + ("criteria[]=#{ criterion }" for key, criterion of @attr.selectedCriteria).join "&"
        success: (data) ->
          alert "loaded"
          @trigger "objectsLoaded", list: data
          return
        # error: (error) ->
        #   @trigger "errorLoadingObjects", error: error
        #   return
        # done: ->
        #   alert "done!"
      return

    @after "initialize", ->
      @on "criterionSelected", (e, data) ->
        @attr.selectedCriteria.push(data.name)
        @attr.selectedCriteria = _.uniq(@attr.selectedCriteria)
        @getAlternatives()


  Toprater.ObjectsData = flight.component(flight.utils.compose(objectsData, withRequest))
  Toprater.ObjectsData.attachTo document
