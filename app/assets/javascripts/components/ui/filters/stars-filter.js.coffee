starsFilter = ->
  @updateValues = (event, data) ->
    @$node.find("input").val([data.value])
    @attr.value = data.value

  @setValue = (event) ->
    @attr.value = $(event.currentTarget).val()
    @trigger 'filtersChanged', @attr

  @resetFilter = ->
    @$node.find("[role=stars-radio]").attr('checked', false)
    @attr.value = {}

  @after 'initialize', ->
    @on @$node.find("[role=stars-radio]"), 'click', @setValue

Toprater.StarsFilter = flight.component(starsFilter, Toprater.withFilterMixin)
Toprater.StarsFilter.attachTo "[role=stars-filter]"
