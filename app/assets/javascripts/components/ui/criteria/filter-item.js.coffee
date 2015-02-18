filterItem = ->
  @attributes
    name: ""
    label: ""

  @removeItem = (event) ->
    @trigger 'uiFilterReset', { filter: @attr.name }


  @after "initialize", ->
    @attr.name = @$node.attr("data-name")
    @on "click", @removeItem

Toprater.FilterItem = flight.component filterItem
