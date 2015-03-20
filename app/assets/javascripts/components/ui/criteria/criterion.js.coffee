criterion = ->

  @after "initialize", ->

    @after "toggleCriterion", ->
      @trigger "uiCriterionToggled", criteria: @attr
      


Toprater.Criterion = flight.component criterion, Toprater.WithCriterionMixin
