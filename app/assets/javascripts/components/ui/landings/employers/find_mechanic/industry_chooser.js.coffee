industryChooser = ->
  @attributes
    choosed: ""
    # ready: false
    slide: ""
    list: "#industries-list"
    button: ".list-control"
    control: ".list-control"

  @scroll = (event) ->
    console.log event
    elem = $(event.target)
    pos = $(event.target).position().top
    event.preventDefault()

    if event.originalEvent.deltaY > 0
      event.stopPropagation(elem)
      for i in [0...30]
        elem.css "top", pos--
        @arrowsVisibility(elem)

        if -elem.position().top >= elem.height() - $(elem).parent().height()
          break


    if event.originalEvent.deltaY < 0
      event.stopPropagation(elem)
      
      for i in [0...30]
        elem.css "top", pos++
        @arrowsVisibility(elem)

        if elem.postion().top == 0
          break

  @industriesList = ->
    @select("list").height(@$node.closest(".slide-wrapper").height() - 150)

  @choose = (event) ->
    event.stopPropagation()
    @attr.choosed = event.target.getAttribute("data-name")
    @select("control").html(event.target.getAttribute("data-label"))
    @trigger @$node.closest("[role=employers-find-company]"), "industryToggled", industry: @attr.choosed



  @after "initialize", ->
    @attr.slide = @$node.closest "[role=employers-find-company]"

    @industriesList()

    @on @$node.find(".list-control"), "click", (event) ->
      @select("list").slideToggle(300)

    @on @select("list"), "scroll", @scroll

    @on @select("list").find("a"), "click", @choose

    @on @select("slide"), "filtersChanged", (event, data) ->
      @attr.ready = data.set
      if @attr.ready
        @trigger @select "slide", "filtersReady"
      else
        @trigger @select "slide", "filtersEmpty"


Toprater.IndustryChooser = flight.component industryChooser
