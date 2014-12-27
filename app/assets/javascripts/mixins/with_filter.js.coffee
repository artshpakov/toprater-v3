withFilterCtr = ->
  @attributes
    name: ''
    value: {}

  @after 'setValue', ->
    @trigger 'filtersChanged', @attr

  @after 'updateValues', (event, data) ->
    @attr.value = data.value

  @after 'resetFilter', ->
    @attr.value = {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')
    @on document, "#{@attr.name}Updated", @updateValues
    @on document, 'filtersReset', @resetFilter

window.Toprater.withFilterMixin = withFilterCtr