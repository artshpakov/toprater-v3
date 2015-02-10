ratingSwitcher = ->

  @switchRating = (event) ->
    @trigger document, "ratingSwitched", dest: event.target.getAttribute "data-dest"


  @after 'initialize', ->
    @on @$node, "click", @switchRating



Toprater.RatingSwitcher = flight.component ratingSwitcher
