$ ->
  criteria = ->
    @attributes
      criterionGroup: "[criterion-group]"
      criterion     : "[criterion]"

    @showSubs = (event) ->
      $(event.target).parents('[criterion-group]').find("[criterion]").toggle()

    @after "initialize", ->
      # @select(@attr.criterion).hide()
      @$node.find("[criterion]").hide()
      @on "[criterion-group-link]", "click", @showSubs
      @on "objectsLoaded", ->
        alert "from criteria"

  Toprater.Criteria = flight.component(criteria)
  Toprater.Criteria.attachTo "[criteria]"
