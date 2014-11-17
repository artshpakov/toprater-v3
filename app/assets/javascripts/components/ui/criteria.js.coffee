$ ->
  Toprater.Criteria = flight.component ->
    # @attributes
    #   criterionGroup: "[criterion-group]"
    #   criterion     : "[criterion]"

    @showSubs = (event) ->
      $(event.target).parents('[criterion-group]').find("[criterion]").toggle()

    @after "initialize", ->
      @on "[criterion-group-link]", "click", @showSubs

  Toprater.Criteria.attachTo "[criteria]"
