criteriaBar = ->

  @scroll = (event) ->
    # console.log event
    elem = @$node.find(".bar-wrap") 
    pos = @$node.find(".bar-wrap").offset().left
    event.preventDefault()
    # event.stopPropagation()

    if event.deltaX > 0
      event.stopPropagation()
      for i in [0...16]
        if -elem.offset().left >= elem.width() - $(window).width()
          break
        elem.css "left", pos--

    if event.deltaX < 0
      event.stopPropagation()
      for i in [0...16]
        if elem.offset().left == 0
          break
        elem.css "left", pos++

  @after "initialize", ->
    @$node.find(".bar-wrap").width _.reduce(_.map(@$node.find(".bar-wrap").children(), (child) -> $(child).outerWidth() + 2), (one, two) -> one + two)
    @on @$node, "mousewheel", @scroll
    @on @$node, "DOMMouseScroll", @scroll



Toprater.CriteriaBar = flight.component criteriaBar
