yearsFilter = ->
  @updateValues = (event, data) ->
    @$node.find("input").val([data.value])

  @setValue = (event) ->
    @attr.value = $(event.currentTarget).val()

  @resetFilter = ->
    @$node.find("[role=years-radio]").attr('checked', false)

  @after 'initialize', ->
    @on @$node.find("[role=years-radio]"), 'click', @setValue

Toprater.YearsFilter = flight.component(yearsFilter, Toprater.withFilterMixin)

