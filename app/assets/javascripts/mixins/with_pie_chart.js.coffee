withPieChart = ->
  @attributes
    chart: -> new Object {}
    data: -> new Array
    options: -> new Object
    destElemClass: -> new String
    ctx: -> new Object
    value: -> new String

  @createCanvas = ->
    width = +@$node.width() - 20
    height = +@$node.height() - 20

    @attr.value = +@$node.attr "data-value"
    chartID = "pie-" + @$node.closest(".#{ @attr.destElemClass }").attr("data-name")
    chartID += Math.floor(Math.random()*10000)
    chartElem = $("<canvas id='#{ chartID }' width='#{ width }' height='#{ height }'></canvas>")
    @$node.append(chartElem)
    @attr.ctx = $("#" + chartID).get(0).getContext "2d"


  @chart = ->
    @attr.chart = new Chart(@attr.ctx).Doughnut @attr.data, @attr.options

  @before "chart", ->
    @createCanvas()
    @setChartData()



Toprater.WithPieChart = withPieChart
