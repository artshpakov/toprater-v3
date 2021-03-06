checkMechanic = ->
  @attributes
    employers: []

  @showSearch = (event, data) ->
    event.stopPropagation()

    @$node.find(".employer-suggest .base").hide()

    @attr.employers = data.result
    @$node.find(".employer-suggest .finded").html JST["employers_list"].render(
      employers: data.result
      )
    @on @$node.find(".employer-suggest a"), "click", @results
    @$node.find(".employer-suggest .finded").show()

    if data.result.length == 1
      @$node.find("input").val(data.result[0].label)



  @getResults = (id) ->
    @trigger @$node, "checkEmployerResultsReq", id: id


  @results = (event) ->
    @$node.find("input").val($(event.target).html())

    @getResults(event.target.getAttribute("data-id"))



  @restart = ->
    @attr.employers = []
    @$node.find("input").val("")
    @$node.find(".finded").html("")
    @$node.find(".base").show()
    @trigger @$node.closest("[role=slide]"), "destroyChartReq"
    @$node.find(".employer-result").css(position: "absolute", width: $(@).parent().width(), height: "100%").animate(
      left: $(window).width()
      ,
      "normal"
      ,
      =>
        @$node.find(".full-slide").show()
        @$node.find(".full-slide").animate(
          left: 0
          ,
          "normal"
          )
        @$node.find(".full-slide").css({position: "static"})
        @$node.find(".employer-result").remove()

      )

  @search = (event) ->
    if @$node.find("input").val().replace(/\s+/g, "").length < 1
      @$node.find(".employer-suggest .finded").hide()
      @$node.find(".employer-suggest .base").show()
      return

    if $.inArray(event.keyCode, [13,16,17,18,19,20,27,35,36,37,38,39,40,91,93,224]) == -1
      @trigger @$node, "findEmployerReq", term: @$node.find("input").val()


  @showEmployer = (event, data) ->
    event.stopPropagation()
    @$node.find(".full-slide").css({ position: "absolute", top: 0 })
    data.employer.percentage = Math.round (data.employer.review_ratings.good + data.employer.review_ratings.excellent) / (data.employer.review_ratings.total / 100.0)
    data.employer.rating = Math.round(((data.employer.overall_rating + 1) * 2.5) * 100) / 100
    data.employer.other_criteria = _.map(data.employer.other_criteria, (val, key) -> 
      val.rating = Math.round(((val.rating + 1) * 2.5) * 100) / 100
      val
      )
    @$node.find(".full-slide").animate(
      left: -$(window).width()
      , 
      "normal"
      ,
      =>
        @$node.find(".full-slide").hide()
        @$node.append(JST["employer_result"].render(
          employer: data.employer
          find_company_title: data.find_company_title
          check_company_title: data.check_company_title
          )
        )
        @trigger @$node.closest("[role=slide]"), "checkEmployerShowed"
        Toprater.CriteriaBar.attachTo "[role=criteria-bar]"
        Toprater.PieChart.attachTo @$node.find("[role=pie-chart]")
        Toprater.LineChart.attachTo @$node.find("[role=criteria-bar]")
        @on @$node.find("[role=restart]"), "click", @restart
        @trigger @$node.closest("[role=slide]"), "redrawChartReq"
      )


  @after "initialize", ->
    @on @$node.find("input"), "keyup", (event) ->
      if event.keyCode == 13
        mapped = _.find(@attr.employers, (emp) => emp.label == @$node.find("input").val())
        if mapped?
          @getResults mapped.id
      else
        @search(event)

    @on @$node, "employersSearchLoaded", @showSearch

    @on @$node.find(".employer-suggest a"), "click", @results

    @on @$node, "employerLoaded", @showEmployer

    @on @$node.find("[role=restart]"), "click", @restart


Toprater.CheckMechanic = flight.component checkMechanic
