withFilterCtr = ->
  @attributes
    name: ''
    value: {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')
    @on document, "#{@attr.name}Updated", @updateValues
    @on document, 'filtersReset', @resetFilter

window.Toprater.withFilterMixin = withFilterCtr