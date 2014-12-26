enumFilter = ->
  @updateValues = (event, data) ->
    @$node.find('select').val(data.value)
    @attr.value = data.value

  @setValue = (event) ->
    @attr.value = $(event.currentTarget).val()
    @trigger 'filtersChanged', @attr

  @resetFilter = ->
    @$node.find('select').val(null)
    @attr.value = {}

  @after 'initialize', ->
    @on @$node.find('select'), 'change', @setValue

Toprater.EnumFilter = flight.component(enumFilter, Toprater.withFilterMixin)
Toprater.EnumFilter.attachTo "[role=enum-filter]"
