autocompleteFilter = ->
  @renderValues = (event, data) ->
    @$node.find('select').val(data.value).trigger('change')

  @setValues = (event) ->
    if $(event.currentTarget).val() == null
      @trigger 'uiFilterReset', { filter: @attr.filterName }
    else
      @attr.value = $(event.currentTarget).val()
      @trigger 'uiFiltersChanged', @attr

  @resetFilter = ->
    @$node.find('select').val([]).trigger('change')

  @after 'initialize', ->
    @$node.find('select').select2
      minimumInputLength: 2
      ajax:
        url: "/suggest/attrs/#{@$node.data('name')}"
        dataType: 'json'
        delay: 350
        data: (params) ->
          { q: params.term }
        cache: true
        processResults: (data) ->
          { results: _.map(data, (item) -> { id: item.name, text: item.label }) }

    @on @$node.find('select'), 'select2:select', @setValues # input change event

Toprater.AutocompleteFilter = flight.component(autocompleteFilter, Toprater.withFilterMixin)
