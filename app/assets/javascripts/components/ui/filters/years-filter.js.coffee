yearsFilter = ->
  @defaultAttrs
    name: ''
    value: {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')

    @on @$node.find("[role=years-radio]"), 'click', (event) ->
      @attr.value = $(event.currentTarget).val()
      @trigger 'filtersChanged', @attr

    @on document, "#{@attr.name}Updated", (event, data) ->
      @$node.find("input").val([data.value])
      @attr.value = data.value

    @on document, 'filtersReset', ->
      @$node.find("[role=years-radio]").attr('checked', false)
      @attr.value = {}

Toprater.YearsFilter = flight.component(yearsFilter)
Toprater.YearsFilter.attachTo "[role=years-filter]"
