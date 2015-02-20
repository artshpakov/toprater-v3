findMechanic = ->
  @attributes
    criteriaReady: false
    filtersReady: false
    currentStep: 1
    buttonState: 0



  @stepPos = (first=false) ->
    _.each @$node.find(".step"), (step, index) ->
      $(step).css({ "left": $(window).width() * index })
      if first
        $(step).show(300)


  @checkButton = ->
    if @attr.criteriaReady and @attr.filtersReady
      @attr.buttonState = 3
    else
      @attr.buttonState = 0
      if @attr.criteriaReady and not @attr.filtersReady
        @attr.buttonState = 1
      if @attr.filtersReady and not @attr.criteriaReady
        @attr.buttonState = 2

    if @attr.buttonState == 3
      @$node.find("[role=slide-results]").addClass("ready")
    if @attr.buttonState == 1
      @$node.find("[role=slide-results]").addClass("ready")
      @$node.find("[role=slide-results]").html("Next")
    if @attr.buttonState == 2 or @attr.buttonState == 3
      @$node.find("[role=slide-results]").html("Show results")
    if @attr.buttonState == 2
      @$node.find("[role=slide-results]").removeClass("ready")
    if @attr.buttonState == 0
      @$node.find("[role=slide-results]").removeClass("ready")



  @makeStep = (targetStep) ->
    _.each @$node.find(".step"), (step, index) =>
      $(step).animate(
        left: (index + 1 - targetStep) * $(window).width()
        ,
        "normal"
        ,
        =>
          @attr.currentStep = targetStep
          @checkButton()
      )


  @results = ->
    @trigger @$node, "uiResultsReq"


  @showResults = (event, data) ->
    event.stopPropagation()
    @$node.find(".full-slide").css({ position: "absolute", top: 0 })
    @$node.find(".full-slide").animate(
      left: - $(window).width()
      ,
      "normal"
      ,
      =>
        @$node.find(".full-slide").hide()
        @$node.append(JST["employers_find_results"].render(
          { employers: _.each data.result, (elem, index) ->
              console.log elem.review_ratings
              elem.place = index + 1
              elem.rating = Math.round(((elem.overall_rating + 1) * 2.5) * 100) / 100
            path: data.path })
        )
        @on @$node.find("[role=restart]"), "click", @restart
      )


  @restart = ->
    @trigger @$node, "restartFindMechanic"

    @attr.criteriaReady = false
    @attr.filtersReady =  false
    @attr.currentStep = 1
    @attr.buttonState = 0

    @makeStep(1)
    @$node.find("#find-company-results").css(position: "absolute", width: $(@).parent().width()).animate(
      left: -$(window).width()
      ,
      "normal"
      ,
      =>
        @$node.find("#find-company-results").remove()
        @$node.find(".full-slide").animate(
          left: +$("[role=employers-find-company]").offset().left
          ,
          "normal"
          ,
          =>
            @$node.find(".full-slide").css({ position: "relative", left: 0 }).show()
          )
      )



  @after "initialize", ->
    @stepPos(true)
    _.each @$node.find(".step"), (step, index) ->
      $(step).css({ "left": $(window).width() * index })
      $(step).show(300)

    @on window, "resize", ->
      @stepPos()

    @on @$node, "criteriaChanged", (event, data) ->
      event.stopPropagation()
      @attr.criteriaReady = data.set
      @checkButton()

    @on @$node, "filtersChanged", (event, data) ->
      event.stopPropagation()
      @attr.filtersReady = data.set
      @checkButton()

    @on @$node.find("[role=slide-results]"), "click", (event) ->
      if @attr.buttonState == 3
        @results()

      if @attr.buttonState == 1
        @makeStep(@attr.currentStep + 1)
        @$node.find(".pagination a").toggleClass("current")

    @on @$node.find(".pagination a"), "click", (event) ->
      @$node.find(".pagination a").removeClass("current")
      $(event.target).addClass("current")
      @makeStep(+event.target.getAttribute("data-step"))

    @on @$node, "gameResultsLoaded", @showResults

    @on @$node.find("[role=restart]"), "click", @restart

Toprater.FindMechanic = flight.component findMechanic
