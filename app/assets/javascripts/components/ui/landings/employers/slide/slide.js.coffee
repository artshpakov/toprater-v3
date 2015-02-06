slide = ->
  @attributes
    number: 0

  @navigate = ->
    $("body, html").animate({ 
      scrollTop: @$node.offset().top 
      }, 500)
    

  @after "initialize", ->
    @$node.height $(window).height()
    @attr.number = Math.floor(Math.random() * (10000 + 1))

    @on document, "slideScrollReq", (event, data) ->
      if data.number == @attr.number then @navigate()

    @on window, "resize", ->
      @$node.height $(window).height()

    @trigger document, "slideInitialized", number: @attr.number


Toprater.Slide = flight.component slide
