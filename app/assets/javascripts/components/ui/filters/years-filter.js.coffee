yearsFilter = ->
  @updateValues = (event, data) ->
    @$node.find("input").val([data.value])
    @attr.value = data.value

  @setValue = (event) ->
    @attr.value = $(event.currentTarget).val()
    @trigger 'filtersChanged', @attr

  @resetFilter = ->
    @$node.find("[role=years-radio]").attr('checked', false)
    @attr.value = {}

  @after 'initialize', ->
    @on @$node.find("[role=years-radio]"), 'click', @setValue

Toprater.YearsFilter = flight.component(yearsFilter, Toprater.withFilterMixin)
Toprater.YearsFilter.attachTo "[role=years-filter]"
