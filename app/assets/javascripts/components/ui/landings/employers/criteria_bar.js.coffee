criteriaBar = ->
  @attributes
    lastX: 0

  @arrowsVisibility = (elem) ->
    if -elem.offset().left >= elem.width() - $(window).width()
      @$node.find("[role=arrow-right]").hide()
    else
      @$node.find("[role=arrow-right]").show()

    if elem.offset().left == 0
      @$node.find("[role=arrow-left]").hide()
    else
      @$node.find("[role=arrow-left]").show()


  @scroll = (event, direction=false, touch=false) ->
    if event.type == "DOMMouseScroll"
      if event.originalEvent.detail > 0
        direction = "right"
      else
        direction = "left"

    # if touch?

    elem = @$node.find(".bar-wrap")
    pos = @$node.find(".bar-wrap").offset().left
    event.preventDefault()

    if event.originalEvent.deltaX > 0 or direction == "right"
      event.stopPropagation(elem)
      for i in [0...30]
        elem.css "left", pos--
        @arrowsVisibility(elem)

        if -elem.offset().left >= elem.width() - $(window).width()
          break


    if event.originalEvent.deltaX < 0 or direction == "left"
      event.stopPropagation(elem)
      
      for i in [0...30]
        elem.css "left", pos++
        @arrowsVisibility(elem)

        if elem.offset().left == 0
          break


  @scrolling = (event, direction) ->
    times = 0
    move = =>
      times++
      if times == 30
        clearInterval interval

      @scroll(event, direction)

    interval = setInterval move, 1


  @after "initialize", ->
    @$node.find(".bar-wrap").width _.reduce(_.map(@$node.find(".bar-wrap").children(":not('.line-chart')"), (child) -> $(child).outerWidth() + 2), (one, two) -> one + two) - 2
    @arrowsVisibility(@$node.find(".bar-wrap"))


    @on @$node, "mousewheel", @scroll
    @on @$node, "DOMMouseScroll", @scroll

    @on @$node, "touchstart", (event) ->
      @attr.lastX = event.originalEvent.changedTouches[0].clientX

    @on window, "touchend", (event) ->
      # event.preventDefault()
      event.stopPropagation()
      delta = event.originalEvent.changedTouches[0].clientX - @attr.lastX
      if Math.abs(delta) > 150
        if delta > 0
          direction = "left"
        else
          direction = "right"
        @scrolling(event, direction, true)
      return

    @on window, "resize", ->
      @arrowsVisibility(@$node.find(".bar-wrap"))

    @on @$node, "click", (event) ->
      targetRole = event.target.getAttribute("role")

      if targetRole == "arrow-left"
        @scrolling(event, "left")

      if targetRole == "arrow-right"
        @scrolling(event, "right")

      if $(event.target).hasClass("fc-link")
        $(document).find("[data-name=find-company]").click()

      if $(event.target).hasClass("cc-link")
        $(document).find("[data-name=user-company]").click()
        
      
      


Toprater.CriteriaBar = flight.component criteriaBar
