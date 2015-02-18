criterion = ->

  @after "initialize", ->

    @after "toggleCriterion", ->
      @trigger "uiCriterionToggled", @attr


Toprater.Criterion = flight.component criterion, Toprater.WithCriterionMixin
