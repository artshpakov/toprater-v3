loadMore = ->
  @after 'initialize', ->
    @on 'click', () ->
      @trigger document, 'loadMore'

Toprater.LoadMore = flight.component loadMore
