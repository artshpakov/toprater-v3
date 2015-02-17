criteriaChooser = ->
  @attributes
    ready: false
    slide: ""



  @after "initialize", ->
    @attr.slide = @$node.closest("[role=employers-find-company]")

    @on @$node.closest("[role=employers-find-company]"), "criteriaChanged", (event, data) ->
      @attr.ready = data.set
      if @attr.ready
        @trigger @$node.closest("[role=employers-find-company]"), "criteriaReady"
      else
        @trigger @$node.closest("[role=employers-find-company]"), "criteriaEmpty"



Toprater.CriteriaChooser = flight.component criteriaChooser
