filterReset = ->

  @triggerReset = ->
    event.stopPropagation()
    @trigger 'filtersReset'
    false

  @after 'initialize', ->
    @on 'click', @triggerReset

Toprater.FilterReset = flight.component(filterReset)
Toprater.FilterReset.attachTo "[role=reset-filters]"
