yearsFilter = ->
  @defaultAttrs
    name: ''
    value: {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')
    @on "[role=years-radio]", 'click', (event) ->
      @attr.value = $(event.currentTarget).val()
      @trigger 'filtersChanged', @attr

    @on document, "#{@attr.name}Updated", (event, data) ->
      console.log "#years-#{data.value}"
      @$node.find("#years-#{data.value}").attr('checked', true)
      @attr.value = data.value

Toprater.YearsFilter = flight.component(yearsFilter)
Toprater.YearsFilter.attachTo "[role=years-filter]"
