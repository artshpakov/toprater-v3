filterReset = ->

  @triggerReset = ->
    @trigger 'uiFiltersReset'
    false

  @after 'initialize', ->
    @on 'click', @triggerReset

Toprater.FilterReset = flight.component(filterReset)
