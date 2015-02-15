criteriaBar = ->
  @attributes
    chart: {}

  @arrowsVisibility = (elem) ->
    if -elem.offset().left >= elem.width() - $(window).width()
      @$node.find("[role=arrow-right]").hide()
    else
      @$node.find("[role=arrow-right]").show()

    if elem.offset().left == 0
      @$node.find("[role=arrow-left]").hide()
    else
      @$node.find("[role=arrow-left]").show()


  @scroll = (event, direction=false) ->
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


  @chart = ->
    width = +@$node.find(".bar-wrap").width() - 300 + 10
    height = +@$node.find(".bar-wrap").height() / 2
    wrapper = @$node.find(".line-chart")
    wrapper.width(width)
    wrapper.height(height)

    chartID = @$node.closest(".employer").attr("data-name")
    chartElem = $("<canvas id='#{ chartID }' width='#{ width }' height='#{ height }'></canvas>")
    wrapper.append(chartElem)

    ctx = $("#" + chartID).get(0).getContext "2d"

    labels = _.map(@$node.find(".bar-wrap .criterion-bar"), (elem) -> elem.getAttribute("data-name"))
    points = _.map(@$node.find(".bar-wrap .criterion-bar"), (elem) -> +elem.getAttribute("data-rating") * 20)


    data = 
      labels: labels
      datasets: [
        label: ""
        fillColor: "rgba(255,255,255, .3)"
        strokeColor: "rgba(220,220,220,1)"
        pointColor: "rgba(220,220,220,1)"
        pointStrokeColor: "#fff"
        pointHighlightFill: "#fff"
        pointHighlightStroke: "rgba(220,220,220,1)"
        data: points
      ]

    options = 
      pointDot:                 false
      scaleGridLineWidth:       0
      bezierCurve :             false
      scaleShowGridLines :      false
      scaleShowHorizontalLines: false
      datasetStroke:            false
      responsive:               true
      animation:                true
      animationSteps:           100
      showScale:                false
      showTooltips:             false

    @attr.chart = new Chart(ctx).Line data, options


  @after "initialize", ->
    @$node.find(".bar-wrap").width _.reduce(_.map(@$node.find(".bar-wrap").children(":not('.line-chart')"), (child) -> $(child).outerWidth() + 2), (one, two) -> one + two) - 2
    @arrowsVisibility(@$node.find(".bar-wrap"))

    @on @$node.closest("[role=slide]"), "slideScrolled", ->
      @chart()

    @on @$node, "mousewheel", @scroll
    # @on @$node, "DOMMouseScroll", @scroll

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
