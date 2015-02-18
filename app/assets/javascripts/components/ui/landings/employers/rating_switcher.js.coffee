ratingSwitcher = ->

  @switchRating = (event) ->
    event.stopPropagation()
    if $(event.target).hasClass("current")
      return
    
    @trigger document, "ratingSwitched", dest: event.target.getAttribute "data-dest"
    @$node.find("a").toggleClass("current")


  @after 'initialize', ->
    @on @$node, "click", @switchRating
    @on document, "employersRatingLoaded", (event, data) ->
      @$node.find("a").removeClass("current")
      @$node.find("a.#{ data.type }").addClass("current")



Toprater.RatingSwitcher = flight.component ratingSwitcher
