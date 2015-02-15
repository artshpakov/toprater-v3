pieChart = ->
  @attributes
    chart: {}

  @chart = ->
    width = +@$node.width() - 20
    height = +@$node.height() - 20

    value = +@$node.attr "data-value"

    chartID = "pie-" + @$node.closest(".employer").attr("data-name")
    chartElem = $("<canvas id='#{ chartID }' width='#{ width }' height='#{ height }'></canvas>")
    @$node.append(chartElem)

    ctx = $("#" + chartID).get(0).getContext "2d"

    data = [
      {
        value: value
        color: "#c1fb85"
        highlight: "#c1fb85"
        label: null
      },
      {
        value: 100 - value
        color:"rgba(0,0,0,0.05)"
        highlight: "rgba(0,0,0,0.05)"
        label: null
      }

    ]

    options =
      segmentShowStroke:      false
      animateRotate:          true
      animateScale:           false
      percentageInnerCutout:  98


    @attr.chart = new Chart(ctx).Doughnut data, options 


  @after "initialize", ->
    @chart()

Toprater.PieChart = flight.component pieChart
