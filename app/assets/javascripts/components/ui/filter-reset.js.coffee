filterReset = ->

  @after 'initialize', ->
    @on 'click', ->
      event.stopPropagation()
      @trigger 'filtersReset'
      false

Toprater.FilterReset = flight.component(filterReset)
Toprater.FilterReset.attachTo "[role=reset-filters]"
