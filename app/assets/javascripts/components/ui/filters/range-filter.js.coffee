rangeFilter = ->
  @updateValues = (event, data) ->
    console.log data
    @$node.find("#range-from").val(data.value.split('-')[0])
    @$node.find("#range-to").val(data.value.split('-')[1])

  @setValue = (event) ->
    @attr.value = @$node.find("#range-from").val() + "-" + @$node.find("#range-to").val()

  @resetFilter = ->
    @$node.find('select').val(null)

  @after 'initialize', ->
    @on @$node.find('select'), 'change', @setValue

Toprater.RangeFilter = flight.component(rangeFilter, Toprater.withFilterMixin)
