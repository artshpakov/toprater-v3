withFilterCtr = ->
  @attributes
    name: ''
    filterName: ''
    value: {}

  @after 'setValue', ->
    @trigger 'uiFiltersChanged', @attr
    return false

  @after 'renderValues', (event, data) ->
    @attr.value = data.value

  @after 'resetFilter', ->
    @attr.value = {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')
    @attr.filterName = toprater.filters[@attr.name].name
    @on document, "#{@attr.filterName}Updated", @renderValues
    @on document, 'uiFiltersReset', @resetFilter

window.Toprater.withFilterMixin = withFilterCtr
