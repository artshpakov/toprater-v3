industryChooser = ->
  @attributes
    choosed: ""
    slide: ""
    list: "#industries-list"
    button: ".list-control"

  @scroll = (event) ->
    elem = $(event.currentTarget).find("ul")
    pos = $(elem).position().top
    scrollbar = $(event.currentTarget).find(".scrollbar")
    scrollbarPos = $(event.currentTarget).find(".scrollbar").position().top
    event.preventDefault()

    if event.originalEvent.deltaY > 0
      event.stopPropagation(elem)
      for i in [0...15]
        elem.css "top", pos--
        if (-pos+1) / (elem.height() / $(event.currentTarget).height()) < $(event.currentTarget).height()
          scrollbar.css "top",  (-pos-1) / (elem.height() / $(event.currentTarget).height())
        else
          console.log "ololo"
          scrollbar.css "top", $(event.currentTarget).height() - scrollbar.height()

        if -elem.position().top >= elem.height() - $(elem).parent().height()
          break


    if event.originalEvent.deltaY < 0
      event.stopPropagation(elem)
      
      for i in [0...15]
        elem.css "top", pos++
        scrollbar.css "top", (-pos-1) / (elem.height() / $(event.currentTarget).height())

        if elem.position().top == 0
          break

  @industriesList = ->
    @select("list").height(@$node.closest(".slide-wrapper").height() - 200)
    @select("list").append("<div class='scrollbar'></div>")

  @choose = (event) ->
    event.stopPropagation()
    @attr.choosed = event.target.getAttribute("data-name")
    @select("button").html(event.target.getAttribute("data-label"))
    @select("list").slideToggle(300)
    @select("list").find("ul").css({ top: 0 })
    @select("list").find(".scrollbar").css({ top: 0 })
    @$node.find(".list-control").toggleClass("open")
    @trigger @$node.closest("[role=employers-find-company]"), "industryToggled", industry: @attr.choosed



  @after "initialize", ->
    @attr.slide = @$node.closest "[role=employers-find-company]"

    @industriesList()

    @on @$node.find(".list-control"), "click", (event) ->
      @select("list").slideToggle(300)
      @$node.find(".list-control").toggleClass("open", => 
        if not $(@).hasClass("open") 
          @select("list").find("ul").css({ top: 0 })
          @select("list").find("ul").css({ top: 0 })
        )

    @on @select("list"), "mousewheel", @scroll

    @on @select("list").find("a"), "click", @choose

    @on @select("slide"), "filtersChanged", (event, data) ->
      @attr.ready = data.set
      if @attr.ready
        @trigger @select "slide", "filtersReady"
      else
        @trigger @select "slide", "filtersEmpty"

    @on @$node.closest("[role=employers-find-company]"), "restartFindMechanic", ->
      @attr.choosed = ""
      @select("button").html("Click to hoose industry...")

Toprater.IndustryChooser = flight.component industryChooser
