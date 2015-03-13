criteriaRating = ->
  @after "initialize", ->
    @on @$node.find('[role=write-review]'), 'click', (event) =>
      @$node.find('.user-review').toggle()

Toprater.CriteriaRating = flight.component criteriaRating
