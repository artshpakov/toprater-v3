yearsFilter = ->
  @defaultAttrs
    name: ''
    value: {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')
    @on "[role=years-radio]", 'click', (event) ->
      @attr.value = $(event.currentTarget).val()
      @trigger 'filtersChanged', @attr

Toprater.YearsFilter = flight.component(yearsFilter)
Toprater.YearsFilter.attachTo "[role=years-filter]"
