slideCriterion = ->

  @after "initialize", ->

    @on @$node.closest("[role=employers-find-company]"), "restartFindMechanic", ->
      @attr.picked = false
      @$node.removeClass "picked"

    @after "toggleCriterion", ->
      @trigger @$node.closest("[role=employers-find-company]"), "criterionToggled", @attr



Toprater.SlideCriterion = flight.component slideCriterion, Toprater.WithCriterionMixin
