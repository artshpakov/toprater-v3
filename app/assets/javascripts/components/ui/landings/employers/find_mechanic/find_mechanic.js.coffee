findMechanic = ->
  @attributes
    criteriaReady: false
    filtersReady: false
    currentStep: 1


  @checkButton = ->
    if @attr.criteriaReady and @attr.filtersReady
      @$node.find("[role=slide-results]").addClass("ready").html("Show results")
    else
      @$node.find("[role=slide-results]").removeClass("ready")

      if @attr.criteriaReady
        @$node.find("[role=slide-results]").addClass("ready").html("Next")
        # console.log @$node.find("[role=slide-results]")
        # @$node.find("[role=slide-results]").addClass("ready").html("Next")
        # @$node.find("[role=slide-results]").remove()

      if @attr.filtersReady
        @$node.find("[role=slide-results]").removeClass("ready").html("Show results")


  @makeStep = (nextStep) ->
    if nextStep > @attr.currentStep
      _.each(@$node.find(".step"), (step, index) =>
        stepLeft = parseInt($(step).css("left"))
        $(step).animate(
          left: stepLeft - $(window).width()
          ,
          "normal"
          ,
          =>
            @attr.currentStep = nextStep
            @checkButton()
        )
      )

    if nextStep < @attr.currentStep
      _.each(@$node.find(".step"), (step, index) =>
        stepLeft = parseInt($(step).css("left"))
        $(step).animate(
          left: stepLeft + $(window).width()
          ,
          "normal"
          ,
          =>
            @attr.currentStep = 1
            @checkButton()
        )
      )


  # @result = ->


  @after "initialize", ->
    _.each @$node.find(".step"), (step, index) ->
      $(step).css({ "left": $(window).width() * index })
      $(step).show(300)


    @on @$node, "criteriaChanged", (event, data) ->
      event.stopPropagation()
      @attr.criteriaReady = data.set
      @checkButton()

    @on @$node, "filtersChanged", (event, data) ->
      event.stopPropagation()
      @attr.filtersReady = data.set
      @checkButton()

    @on @$node.find("[role=slide-results]"), "click", (event) ->
      if $(event.target).hasClass("ready")
        @makeStep(@attr.currentStep + 1)

    


Toprater.FindMechanic = flight.component findMechanic
