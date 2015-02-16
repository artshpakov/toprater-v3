criterion = ->

  @after "initialize", ->

    @after "toggleCriterion", ->
      @trigger "criterionToggled", @attr


Toprater.Criterion = flight.component criterion, Toprater.WithCriterionMixin
