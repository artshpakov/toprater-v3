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
    @$node.html @$node.html().toLowerCase().replace(@attr.best, "<a href='javascript:;' data-dest='best' class='bwswitch selected' role='switcher'>" + @attr.best + "</a>")
    @$node.html @$node.html().toLowerCase().replace(@attr.worst, "<a href='javascript:;' data-dest='worst' class='bwswitch' role='switcher'>" + @attr.worst + "</a>")

    Toprater.RatingSwitcher.attachTo "[role=switcher]"
    Toprater.NextSlide.attachTo "[role=next-slide]"

    @on "click", @toggleView

Toprater.TitleSwitcher = flight.component titleSwitcher
