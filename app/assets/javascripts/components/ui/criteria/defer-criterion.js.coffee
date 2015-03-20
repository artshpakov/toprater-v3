deferCriterion = ->
  @after "initialize", ->
    @after "toggleCriterion", ->
      @trigger @$node, "uiCriterionToggled", @attr




Toprater.DeferCriterion = flight.component deferCriterion, Toprater.WithCriterionMixin
