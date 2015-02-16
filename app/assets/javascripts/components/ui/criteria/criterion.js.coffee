criterion = ->

  @after "initialize", ->

    @after "toggleCriterion", ->
      @trigger "criterionToggled", @attr
      @$node.toggleClass "picked"


Toprater.Criterion = flight.component criterion, Toprater.WithCriterionMixin
