employersRating = ->

  @switchRating = (event, data) ->
    @$node.html $(data.objects).find("#employers-rating")

    Toprater.SlideNav.teardownAll()
    Toprater.Slide.teardownAll()
    Toprater.SlideNav.attachTo "[role=slide-nav]"
    Toprater.Slide.attachTo "[role=slide]"
    Toprater.NextSlide.attachTo "[role=next-slide]"
    Toprater.RatingSwitcher.attachTo "[role=switcher]"
    $("[role=slide-nav]").find("a")[1].click()


  @after 'initialize', ->
    $("body").css("overflow", "hidden");
    @on document, "employersRatingLoaded", @switchRating

Toprater.EmployersRating = flight.component employersRating
