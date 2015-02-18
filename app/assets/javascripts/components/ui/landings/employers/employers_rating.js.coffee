employersRating = ->

  @switchRating = (event, data) ->
    @$node.html $(data.objects).find("#employers-rating")

    Toprater.SlideNav.teardownAll()
    Toprater.Slide.teardownAll()
    Toprater.SlideNav.attachTo "[role=slide-nav]"
    Toprater.Slide.attachTo "[role=slide]"
    Toprater.NextSlide.attachTo "[role=next-slide]"
    Toprater.CriteriaBar.attachTo "[role=criteria-bar]"
    Toprater.PieChart.attachTo "[role=pie-chart]"
    Toprater.LineChart.attachTo "[role=criteria-bar]"
    Toprater.DataFindMechanic.attachTo "[role=employers-find-company]"
    Toprater.FindMechanic.attachTo "[role=employers-find-company]"
    Toprater.SlideCriterion.attachTo "[role=slide-criterion]"
    Toprater.CriteriaChooser.attachTo "[role=criteria-chooser]"
    Toprater.IndustryChooser.attachTo "[role=industry-chooser]"
    Toprater.RatingSwitcher.attachTo "[role=switcher]"
    $("[role=slide-nav]").find("a")[1].click()


  @after 'initialize', ->
    $("body").css("overflow", "hidden");
    @on document, "employersRatingLoaded", @switchRating

Toprater.EmployersRating = flight.component employersRating
