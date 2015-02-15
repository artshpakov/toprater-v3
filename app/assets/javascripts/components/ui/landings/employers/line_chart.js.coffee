lineChart = ->
  @attributes
    chart: {}

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

    @on document, "slideScrollReq", ->
      if @attr.chart.destroy?
        @attr.chart.destroy()

    @on @$node.closest("[role=slide]"), "redrawChartReq", ->
      _.defer(_.bind @chart, @)


Toprater.LineChart = flight.component lineChart
