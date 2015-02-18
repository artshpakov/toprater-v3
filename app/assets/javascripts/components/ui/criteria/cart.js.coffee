cart = ->
  @render = (event, data) ->
    filters = _.map data.filters, (filter) ->
      str = filterToUrl(filter.name, filter.value).split('/')
      { name: str[1], value: str[2] }

    @$node.find('.token').remove()
    @$node.prepend JST['cart'].render({ criteria: data.criteria, filters: filters })
    Toprater.FilterItem.attachTo "[role=filter]"
    Toprater.Criterion.attachTo "[role=criterion]"


  @after "initialize", ->
    @on document, "dataStateUpdated", @render

Toprater.Cart = flight.component cart
