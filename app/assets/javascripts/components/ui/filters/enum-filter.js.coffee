enumFilter = ->
  @updateValues = (event, data) ->
    @$node.find('select').val(data.value)

  @setValue = (event) ->
    @attr.value = $(event.currentTarget).val()

  @resetFilter = ->
    @$node.find('select').val(null)

  @after 'initialize', ->
    @on @$node.find('select'), 'change', @setValue

Toprater.EnumFilter = flight.component(enumFilter, Toprater.withFilterMixin)
