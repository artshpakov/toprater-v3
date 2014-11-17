$ ->
  objectsData = ->
    @attributes
      selectedCriteria: []

    @getAlternatives = ->
      @attr.selectedCriteria = _.uniq(@attr.selectedCriteria)
      self = @
      $.ajax(
        url: "hotels/objects?" + ("criteria[]=#{ criterion }" for key, criterion of @attr.selectedCriteria).join "&"
        method: "get"
      ).done( (data) ->
        self.trigger "objectsLoaded", list: data
        )
      # @get
      #   url: "hotels/objects?" + ("criteria[]=#{ criterion }" for key, criterion of @attr.selectedCriteria).join "&"
      #   context: @
      #   success: (data) ->
      #     alert "loaded"
      #     @trigger "objectsLoaded", list: data
      #     return
        # error: (error) ->
        #   @trigger "errorLoadingObjects", error: error
        #   return

    @after "initialize", ->

      @on "criterionSelected", (event, data) ->
        @attr.selectedCriteria.push(data.name)
        @getAlternatives()

      @on "criterionUnselected", (event, data) ->
        @attr.selectedCriteria = _.reject(@attr.selectedCriteria, [data.name])
        @getAlternatives()

  # objectsData = flight.compose.mixin(objectsData, withRequest)
  Toprater.ObjectsData = flight.component(objectsData, withRequest)
  Toprater.ObjectsData.attachTo document
