rangeFilter = ->
  @renderValues = (event, data) ->
    @$node.find("#range-from").val(data.value.from)
    @$node.find("#range-to").val(data.value.to)

  @setValue = (event) ->
    @attr.value = 
      from: @$node.find("#range-from").val()
      to: @$node.find("#range-to").val()

  @resetFilter = ->
    @$node.find('select').val(null)

  @after 'initialize', ->
    @on @$node.find('select'), 'change', @setValue

Toprater.RangeFilter = flight.component(rangeFilter, Toprater.withFilterMixin)
