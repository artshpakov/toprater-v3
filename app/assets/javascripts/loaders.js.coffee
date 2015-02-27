Toprater.attachFilters = ->
  Toprater.EnumFilter.attachTo "[role=enum-filter]"
  Toprater.RangeFilter.attachTo "[role=range-filter]"
  Toprater.StarsFilter.attachTo "[role=stars-filter]"
  Toprater.YearsFilter.attachTo "[role=years-filter]"

Toprater.attachDataComponents = ->
  Toprater.AppState.attachTo document
  Toprater.DataResults.attachTo "[role=result]"
  Toprater.Router.attachTo document
  Toprater.DataCard.attachTo "[role=result]"
  Toprater.CompleterResults.attachTo document

Toprater.attachUIComponents = ->
  Toprater.Cart.attachTo "[role=cart]"
  Toprater.Criteria.attachTo "[role=criteria]"
  Toprater.Criterion.attachTo "[role=criterion]"
  Toprater.FilterItem.attachTo "[role=filter]"
  Toprater.Search.attachTo "[role=search]"
  Toprater.PricesCalendar.attachTo "[role=prices-calendar]"
  Toprater.PricesTable.attachTo "[role=prices-table]"
  Toprater.FilterReset.attachTo "[role=reset-filters]"
  Toprater.Result.attachTo "[role=result]"
  Toprater.Reviews.attachTo "[role=reviews]"
  Toprater.Auth.attachTo "[role=auth]"
  Toprater.Completer.attachTo "[role=completer]"
  Toprater.Card.attachTo "[role=card]"
  Toprater.LoadMore.attachTo "[role=load-more]"
  Toprater.MapCanvas.attachTo "[role=map-canvas]"
  Toprater.attachFilters()
  Toprater.Hints.attachTo document

Toprater.attachEmployersLandingComponents = ->
  Toprater.DataEmployers.attachTo document
  Toprater.SlideNav.attachTo "[role=slide-nav]"
  Toprater.Slide.attachTo "[role=slide]"
  Toprater.NextSlide.attachTo "[role=next-slide]"
  Toprater.RatingSwitcher.attachTo "[role=switcher]"
  Toprater.TitleSwitcher.attachTo "[role=title-switcher]"
  Toprater.EmployersRating.attachTo "[role=employers-rating]"
  Toprater.CriteriaBar.attachTo "[role=criteria-bar]"
  Toprater.PieChart.attachTo "[role=pie-chart]"
  Toprater.LineChart.attachTo "[role=criteria-bar]"

  Toprater.DataFindMechanic.attachTo "[role=employers-find-company]"
  Toprater.FindMechanic.attachTo "[role=employers-find-company]"
  Toprater.CriteriaChooser.attachTo "[role=criteria-chooser]"
  Toprater.SlideCriterion.attachTo "[role=slide-criterion]"
  Toprater.IndustryChooser.attachTo "[role=industry-chooser]"

  Toprater.CheckMechanic.attachTo "[role=employers-check-company]"
  Toprater.DataCheckMechanic.attachTo "[role=employers-check-company]"

  Toprater.Subscriber.attachTo "[role=subscriber]"


  # Toprater.Slider.attachTo "[role=slider]"
