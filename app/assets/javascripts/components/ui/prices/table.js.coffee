pricesTable = ->

  @render = (prices) ->
    @$node.html JST['prices'].render { prices } if prices?

  @after 'initialize', ->
    @on document, 'pricesLoad', => @$node.text 'loading...'
    @on document, 'pricesLoaded', (event, data) => @render data.prices
      

Toprater.PricesTable = flight.component pricesTable
