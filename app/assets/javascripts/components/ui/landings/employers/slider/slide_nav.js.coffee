slideNav = ->
  @attributes
    slides: []
    lastY: 0

  @renderNav = ->
    @$node.html JST['slider_nav'].render { slides: @attr.slides }

  @registerSlide = (event, data) ->
    if data.current
      _.find(@attr.slides, (slide) -> slide.current)?.current = false
    @renderNav()

  @navigate = (event) ->
    if event.target.tagName.toLowerCase() == "a"
      event.stopPropagation()
      event.preventDefault()
      slideName = event.target.getAttribute "data-name"
      @trigger document, "slideScrollReq", name: slideName
      _.find(@attr.slides, (slide) -> slide.current)?.current = false
      _.find(@attr.slides, (slide) -> slide.name == slideName)?.current = true
      @renderNav()


  @nextSlide = (event) ->
    currentSlide = _.find @attr.slides, (slide) -> slide.current
    nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + 1]
    @$node.find("[data-name=#{ nextSlide.name }]").click()

  @scroll = (event, touch, direction) ->

    if event.type == "DOMMouseScroll"
      if event.originalEvent.detail > 0
        currentSlide = _.find @attr.slides, (slide) -> slide.current
        nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + 1]
        if nextSlide?
          slideName = nextSlide.name
          $("[data-name=#{slideName}]").click()
      else
        currentSlide = _.find @attr.slides, (slide) -> slide.current
        nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + -1]
        if nextSlide?
          slideName = nextSlide.name
          $("[data-name=#{slideName}]").click()
      return
    
    down = event.which == 40 or event.which == 34
    up = event.which == 38 or event.which == 33

    if touch?
      if direction == "up"
        up = true
      else
        down = true

    if event.clientY > 200 or up or down
      if (event.originalEvent.deltaY > 0) or (event.type == "DOMMouseScroll" and event.originalEvent.detail > 0) or down
        currentSlide = _.find @attr.slides, (slide) -> slide.current
        nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + 1]
        if nextSlide?
          slideName = nextSlide.name
          $("[data-name=#{slideName}]").click()
              
      if event.originalEvent.deltaY < 0 or (event.type == "DOMMouseScroll" and event.originalEvent.detail < 0) or up
        currentSlide = _.find @attr.slides, (slide) -> slide.current
        nextSlide = @attr.slides[_.indexOf(@attr.slides, currentSlide) + -1]
        if nextSlide?
          slideName = nextSlide.name
          $("[data-name=#{slideName}]").click()


  @scrolling = _.throttle @scroll, 1200, trailing: false


  @after "initialize", ->
    @attr.slides = []
    @on document, "slideInitialized", @registerSlide

    @on @$node, "click", @navigate

    @on document, "nextSlide", @nextSlide

    @on window, "mousewheel", (event) ->
      event.preventDefault()
      event.stopPropagation()
      @scrolling(event)

    @on window, "DOMMouseScroll", (event) ->
      event.preventDefault()
      event.stopPropagation()
      @scrolling(event)

    @on window, "touchmove", (event) ->
      event.preventDefault()
      event.stopPropagation()

    @on window, "touchstart", (event) ->
      @attr.lastY = event.originalEvent.changedTouches[0].clientY

    @on window, "touchend", (event) ->
      delta = event.originalEvent.changedTouches[0].clientY - @attr.lastY
      if Math.abs(delta) > 100
        if delta > 0
          direction = "up"
        else
          direction = "down"
        @scrolling(event, true, direction)
      return



    @on window, "keydown", (event) ->
      if event.which == 38 or event.which == 40 or event.which == 33 or event.which == 34
        @scroll(event)
        

Toprater.SlideNav = flight.component slideNav
