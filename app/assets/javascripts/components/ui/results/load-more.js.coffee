loadMore = ->
  @after 'initialize', ->
    @on 'click', () ->
      _kmq.push(['record', 'Load More Clicked'])
      @trigger document, 'loadMore'

Toprater.LoadMore = flight.component loadMore
