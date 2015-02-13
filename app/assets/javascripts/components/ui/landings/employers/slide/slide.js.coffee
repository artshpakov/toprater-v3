slide = ->
  @attributes
    name: ""

  @navigate = (speed=500) ->
    @off window, "scroll"
    $("body, html").animate({ 
      scrollTop: @$node.offset().top 
      }, 
      speed,
      =>
        @trigger document, "slideScrolled"
        @trigger @$node, "slideScrolled"
      )
    
  @isCurrent = ->
    viewportTop = $(window).scrollTop()
    viewportBottom = $(window).scrollTop() + $(window).height()
    viewportMiddle = viewportTop + $(window).height() / 2


    slideTop = @$node.offset().top
    slideBottom = slideTop + @$node.height()

    (slideTop >= viewportTop and slideTop <= viewportMiddle) or (slideBottom > viewportMiddle and slideBottom < viewportBottom)

  @fixPosition = ->
    if @isCurrent()
      @navigate 400


  @after "initialize", ->
    @$node.height $(window).height()
    @attr.name = @$node.attr "data-name"
    @fixPosition()

    @on document, "slideScrollReq", (event, data) ->
      if data? and data.name == @attr.name then @navigate()
      
    @on window, "resize", ->
      @$node.height $(window).height()
      @fixPosition()

    @trigger document, "slideInitialized", { name: @attr.name, current: @isCurrent() }


Toprater.Slide = flight.component slide
