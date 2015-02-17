slideCriterion = ->

  @after "initialize", ->

    @after "toggleCriterion", ->
      @trigger @$node.closest("[role=employers-find-company]"), "criterionToggled", @attr


Toprater.SlideCriterion = flight.component slideCriterion, Toprater.WithCriterionMixin
