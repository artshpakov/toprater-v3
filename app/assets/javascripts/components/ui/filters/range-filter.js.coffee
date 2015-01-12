rangeFilter = ->
  @updateValues = (event, data) ->
    @$node.find("##{@attr.name}-from").val(data.value.split('-')[0])
    @$node.find("##{@attr.name}-to").val(data.value.split('-')[1])

  @setValue = (event) ->
    @attr.value = @$node.find("##{@attr.name}-from").val() + "-" + @$node.find("##{@attr.name}-to").val()

  @resetFilter = ->
    @$node.find('select').val(null)

  @after 'initialize', ->
    @on @$node.find('select'), 'change', @setValue

Toprater.RangeFilter = flight.component(rangeFilter, Toprater.withFilterMixin)
Toprater.RangeFilter.attachTo "[role=range-filter]"