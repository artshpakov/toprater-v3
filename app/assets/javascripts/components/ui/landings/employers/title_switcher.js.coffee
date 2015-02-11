titleSwitcher = ->
  @attributes
    best: "best"
    worst: "worst"

  @toggleView = (event) ->
    if $(event.target).hasClass("bwswitch")
      event.preventDefault()
      event.stopPropagation()
      @$node.find("a.bwswitch").toggleClass "selected"


  @after 'initialize', ->
    if @$node.attr("data-worst") == "true"
      @$node.html @$node.html().toLowerCase().replace(@attr.best, "<a href='javascript:;' data-dest='best' class='bwswitch selected' role='switcher'>" + @attr.best + "</a>")
      @$node.html @$node.html().toLowerCase().replace(@attr.worst, "<a href='javascript:;' data-dest='worst' class='bwswitch' role='switcher'>" + @attr.worst + "</a>")
      @on "click", @toggleView
      Toprater.RatingSwitcher.attachTo "[role=switcher]"
    else
      @$node.html @$node.html().toLowerCase().replace("and worst", "")


    Toprater.NextSlide.attachTo "[role=next-slide]"

    

Toprater.TitleSwitcher = flight.component titleSwitcher
