criteria = ->
  # console.log "criteria"
  @attributes
    criterionGroup: "[role=criterion-group]"
    criterion     : "[role=criterion]"

  @showSubs = (event) ->
    $(event.target).parents('[role=criterion-group]').find("[role=criterion]").toggle()

  @after "initialize", ->
    @select("criterion").hide()
    @$node.css({ opacity: 1 })

    @on "[role=criterion-group-link]", "click", @showSubs

Toprater.Criteria = flight.component(criteria)
Toprater.Criteria.attachTo "[role=criteria]"
