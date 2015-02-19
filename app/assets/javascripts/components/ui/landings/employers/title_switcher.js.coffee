titleSwitcher = ->
  @attributes
    best: "best"
    worst: "worst"


  @after 'initialize', ->
    if @$node.attr("data-worst") == "true"
      @$node.find("span").html @$node.find("span").html().toLowerCase().replace(@attr.best, "<a href='javascript:;' data-dest='best' class='#{ @attr.best } bwswitch current'>" + @attr.best + "</a>")
      @$node.find("span").html @$node.find("span").html().toLowerCase().replace(@attr.worst, "<a href='javascript:;' data-dest='worst' class='#{ @attr.worst } bwswitch'>" + @attr.worst + "</a>")
      Toprater.RatingSwitcher.attachTo "[role=switcher]"
    else
      @$node.html @$node.html().toLowerCase().replace("and worst", "")


    Toprater.NextSlide.attachTo "[role=next-slide]"

    

Toprater.TitleSwitcher = flight.component titleSwitcher
