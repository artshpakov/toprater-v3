withFilterCtr = ->
  @attributes
    name: ''
    filterName: ''
    value: {}

  @after 'setValue', ->
    @trigger 'filtersChanged', @attr

  @after 'updateValues', (event, data) ->
    @attr.value = data.value

  @after 'resetFilter', ->
    @attr.value = {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')
    @attr.filterName = toprater.filters[@attr.name].name
    @on document, "#{@attr.filterName}Updated", @updateValues
    @on document, 'filtersReset', @resetFilter

window.Toprater.withFilterMixin = withFilterCtr
