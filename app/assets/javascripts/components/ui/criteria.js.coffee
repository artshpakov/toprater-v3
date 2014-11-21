criteria = ->
  # console.log "criteria"
  @attributes
    criterionGroup: "[criterion-group]"
    criterion     : "[criterion]"

  @showSubs = (event) ->
    $(event.target).parents('[criterion-group]').find("[criterion]").toggle()

  @after "initialize", ->
    @select("criterion").hide()
    @on "[criterion-group-link]", "click", @showSubs

Toprater.Criteria = flight.component(criteria)
Toprater.Criteria.attachTo "[criteria]"
