appState = ->
  @attributes
    selectedCriteria: []

  @getAlternatives = ->
    self = @
    $.ajax(
      url: "hotels/objects?" + ("criteria[]=#{ criterion }" for key, criterion of @attr.selectedCriteria).join "&"
      method: "GET"
    )
    .fail( (data) ->
      self.trigger "errorLoadingObjects", data
    )
    .done( (data) ->
      self.trigger "objectsLoaded", objects: data
      )



  @after "initialize", ->
    @on "criterionToggled", (event, data) ->
      if _.contains _.pluck(@attr.selectedCriteria, "name"), data.name
        @attr.selectedCriteria = _.reject @attr.selectedCriteria, (criterion) -> criterion.name == data.name
      else
        @attr.selectedCriteria.push data

      @trigger "criteriaUpdated", criteria: @attr.selectedCriteria

      @getAlternatives()


Toprater.AppState = flight.component appState
Toprater.AppState.attachTo document
