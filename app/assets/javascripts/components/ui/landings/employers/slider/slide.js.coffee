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

        if @isCurrent()
          @trigger @$node, "redrawChartReq"
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

  @toggleDesc = ->

    if @$node.find(".desc").length
      if @$node.find(".desc-text").html().length > 200
        @$node.find(".showmore").show()
        @$node.find(".desc-text").html(@$node.find(".desc-text").html().slice(0, 200) + "...")
      else
        @$node.find(".showmore").hide()
      @$node.find(".desc-text").show()


  @after "initialize", ->
    @$node.height $(window).height()
    @attr.name = @$node.attr "data-name"
    @fixPosition()
    @toggleDesc()

    @on @$node.find(".link-to-mechanic .button"), "click", (event) ->
      targetSlide = event.target.getAttribute "data-dest"
      $(document).find("[data-name=#{targetSlide}]").click()

    @on document, "slideScrollReq", (event, data) ->
      if data? and data.name == @attr.name then @navigate()
      
    @on window, "resize", ->
      @$node.height $(window).height()
      @fixPosition()

    @on @$node, "checkEmployerShowed", ->
      @toggleDesc()

    @trigger document, "slideInitialized", { name: @attr.name, current: @isCurrent() }


Toprater.Slide = flight.component slide
