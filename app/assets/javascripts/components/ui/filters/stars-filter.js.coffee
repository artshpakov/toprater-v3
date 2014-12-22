starsFilter = ->
  @defaultAttrs
    name: ''
    value: {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')
    @on "[role=stars-radio]", 'click', (event) ->
      @attr.value = $(event.currentTarget).val()
      @trigger 'filtersChanged', @attr

Toprater.StarsFilter = flight.component(starsFilter)
Toprater.StarsFilter.attachTo "[role=stars-filter]"