yearsFilter = ->
  @renderValues = (event, data) ->
    @$node.find("input").val(["#{data.value.from}-#{data.value.to}"])

  @setValue = (event) ->
    range = $(event.currentTarget).val().split('-')
    @attr.value =
      from: range[0]
      to: range[1]

  @resetFilter = ->
    @$node.find("[role=years-radio]").attr('checked', false)

  @after 'initialize', ->
    @on @$node.find("[role=years-radio]"), 'click', @setValue

Toprater.YearsFilter = flight.component(yearsFilter, Toprater.withFilterMixin)

