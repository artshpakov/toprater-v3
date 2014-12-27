starsFilter = ->
  @updateValues = (event, data) ->
    @$node.find("input").val([data.value])

  @setValue = (event) ->
    @attr.value = $(event.currentTarget).val()

  @resetFilter = ->
    @$node.find("[role=stars-radio]").attr('checked', false)

  @after 'initialize', ->
    @on @$node.find("[role=stars-radio]"), 'click', @setValue

Toprater.StarsFilter = flight.component(starsFilter, Toprater.withFilterMixin)
Toprater.StarsFilter.attachTo "[role=stars-filter]"
