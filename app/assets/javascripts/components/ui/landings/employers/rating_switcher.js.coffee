ratingSwitcher = ->

  @switchRating = (event) ->
    if $(event.target).hasClass("current")
      return
    
    @trigger document, "ratingSwitched", dest: event.target.getAttribute "data-dest"
    $("[role=switcher]").find("a").removeClass("current")
    $("[role=switcher]").find("a.#{ event.target.getAttribute "data-dest" }").addClass("current")
    $("header").toggleClass("header-best header-worst")



  @after 'initialize', ->
    @on @$node, "click", @switchRating



Toprater.RatingSwitcher = flight.component ratingSwitcher
