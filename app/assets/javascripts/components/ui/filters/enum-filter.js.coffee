enumFilter = ->
  @defaultAttrs
    name: ''
    value: {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')

    @on document, "#{@attr.name}Updated", (event, data) ->
      @$node.find('select').val(data.value)
      @attr.value = data.value

    @on document, 'filtersReset', ->
      @$node.find('select').val(null)
      @attr.value = {}

    @on @$node.find('select'), 'change', (event) ->
      @attr.value = $(event.currentTarget).val()
      @trigger 'filtersChanged', @attr

Toprater.EnumFilter = flight.component(enumFilter)
Toprater.EnumFilter.attachTo "[role=enum-filter]"
