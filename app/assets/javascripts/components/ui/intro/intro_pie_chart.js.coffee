introPieChart = ->
  @attributes
    elements: 0


  @setChartData = ->
    @attr.data = [
      {
        value: @attr.value
        color: "#0297dd"
        highlight: "#0297dd"
        label: null
      },
      {
        value: 100 - @attr.value
        color: "#e4e4e4"
        highlight: "#e4e4e4"
        label: null
      }
    ]

    @attr.options =
      segmentShowStroke:      false
      animateRotate:          true
      animateScale:           false
      percentageInnerCutout:  90
      animationEasing:        "easeOut"
      animationSteps:         30
    
    
  @createChart = ->
    if @attr.chart.destroy?
      @attr.chart.destroy()
      @$node.find("canvas").remove()
    @chart()
    @off @$node.closest(".popular-thumb"), "mouseover"

    if @attr.elements != @attr.elements = $(".popular-thumb").length
      Toprater.IntroPieChart.attachTo "[role=intro-pie-chart]"


  @dropChart= ->
    if @attr.chart.destroy?
      @attr.chart.destroy()
      @$node.find("canvas").remove()
    @on @$node.closest(".popular-thumb"), "mouseover", @createChart


  @after "initialize", ->
    @attr.elements = $(".popular-thumb").length
    @attr.destElemClass = "pie-chart-wrapper"
    @on @$node.closest(".popular-thumb"), "mouseover", @createChart
    @on @$node.closest(".popular-thumb"), "mouseleave", @dropChart





Toprater.IntroPieChart = flight.component introPieChart, Toprater.WithPieChart
