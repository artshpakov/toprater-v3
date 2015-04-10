employersPieChart = ->

  @setChartData = ->
    @attr.data = [
      {
        value: @attr.value
        color: "#c1fb85"
        highlight: "#c1fb85"
        label: null
      },
      {
        value: 100 - @attr.value
        color:"rgba(0,0,0,0.05)"
        highlight: "rgba(0,0,0,0.05)"
        label: null
      }
    ]

    @attr.options =
      segmentShowStroke:      false
      animateRotate:          true
      animateScale:           false
      percentageInnerCutout:  98
      animationEasing:        "easeOut"
      animationSteps:         30


  @after "initialize", ->
    @attr.destElemClass = "employer"

    @on document, "slideScrollReq", ->
      if @attr.chart.destroy?
        @attr.chart.destroy()
        @$node.find("canvas").remove()

    @on @$node.closest("[role=slide]"), "redrawChartReq", ->
      if @attr.chart.destroy?
        @attr.chart.destroy()
        @$node.find("canvas").remove()      
      @chart()

    @on @$node.closest("[role=slide]"), "destroyChartReq", ->
      @teardown()

Toprater.EmployersPieChart = flight.component employersPieChart, Toprater.WithPieChart
