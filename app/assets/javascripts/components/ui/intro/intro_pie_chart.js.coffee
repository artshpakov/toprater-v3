introPieChart = ->
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

    #FIXME: dirty hack to ensure canvas has unique id. Need for work with slick carousel
    canvas = @$node.find("canvas")
    canvas.attr("id", canvas.attr("id") + Math.floor(Math.random()*1000))


  @after "initialize", ->
    @attr.destElemClass = "pie-chart-wrapper"
    @chart()
    console.log @attr.ctx.canvas



Toprater.IntroPieChart = flight.component introPieChart, Toprater.WithPieChart
