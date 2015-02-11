slideNav = ->
  @attributes
    slides: []

  @renderNav = ->
    @$node.html JST['slider_nav'].render { slides: @attr.slides }

  @registerSlide = (event, data) ->
    @attr.slides.push { name: data.name, current: data.current }
    @renderNav()

  @navigate = (event) ->
    event.stopPropagation()
    if event.target.tagName.toLowerCase() == "a"
      slideName = event.target.getAttribute "data-name"
      @trigger document, "slideScrollReq", name: slideName
      _.find(@attr.slides, (slide) -> slide.current).current = false
      _.find(@attr.slides, (slide) -> slide.name == slideName).current = true
      @renderNav()


  @nextSlide = (event) ->
    currentSlide = _.find @attr.slides, (slide) -> slide.current
    nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + 1]
    @$node.find("[data-name=#{ nextSlide.name }]").click()

  calling = false
  @scroll = (event) ->
    event.preventDefault()
    event.stopPropagation()

    if calling then return

    move = =>
      calling = true
      down = event.which == 40 or event.which == 34
      up = event.which == 38 or event.which == 33
      if event.clientY > 200 or up or down
        # FIXME: fix in Firefox!
        if event.originalEvent.deltaY > 0 or down
          currentSlide = _.find @attr.slides, (slide) -> slide.current
          nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + 1]
          if nextSlide?
            slideName = nextSlide.name
            $("[data-name=#{slideName}]").click()
            
        # FIXME: fix in Firefox!              
        if event.originalEvent.deltaY < 0 or up
          currentSlide = _.find @attr.slides, (slide) -> slide.current
          nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + -1]
          if nextSlide?
            slideName = nextSlide.name
            $("[data-name=#{slideName}]").click()          

      _.delay(
        -> calling = false
        1200)

    move()



  @after "initialize", ->
    @attr.slides = []
    @on document, "slideInitialized", @registerSlide

    @on @$node, "click", @navigate

    @on document, "nextSlide", @nextSlide

    @on window, "mousewheel", @scroll
    @on window, "DOMMouseScroll", @scroll

    @on window, "keydown", (event) ->
      if event.which == 38 or event.which == 40 or event.which == 33 or event.which == 34
        @scroll(event)


Toprater.SlideNav = flight.component slideNav
