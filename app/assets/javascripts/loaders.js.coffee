Toprater.attachFilters = ->
  Toprater.EnumFilter.attachTo "[role=enum-filter]"
  Toprater.RangeFilter.attachTo "[role=range-filter]"
  Toprater.StarsFilter.attachTo "[role=stars-filter]"
  Toprater.YearsFilter.attachTo "[role=years-filter]"
  Toprater.AutocompleteFilter.attachTo "[role=multi-completer-filter]"

Toprater.attachDataComponents = ->
  Toprater.AppState.attachTo document
  Toprater.DataResults.attachTo "[role=objects-list]"
  Toprater.Router.attachTo document
  Toprater.DataCard.attachTo "[role=content]"
  Toprater.CompleterResults.attachTo document
  Toprater.DataSubscriber.attachTo document
  Toprater.DataReviews.attachTo document

Toprater.attachUIComponents = ->
  Toprater.Cart.attachTo "[role=cart]"
  Toprater.Criteria.attachTo "[role=criteria]"
  Toprater.Criterion.attachTo "[role=criterion]"
  Toprater.DeferCriterion.attachTo "[role=defer-criterion]"
  Toprater.ChooseHandler.attachTo "[role=chooser-handler]"
  Toprater.FilterItem.attachTo "[role=filter]"
  Toprater.Search.attachTo "[role=search]"
  Toprater.PricesCalendar.attachTo "[role=prices-calendar]"
  Toprater.PricesTable.attachTo "[role=prices-table]"
  Toprater.FilterReset.attachTo "[role=reset-filters]"
  Toprater.Result.attachTo "[role=objects-list]"
  Toprater.Reviews.attachTo "[role=reviews]"
  Toprater.Auth.attachTo "[role=auth]"
  Toprater.Completer.attachTo "[role=completer]"
  Toprater.Card.attachTo "[role=card]"
  Toprater.LoadMore.attachTo "[role=load-more]"
  Toprater.MapCanvas.attachTo "[role=map-canvas]"
  Toprater.attachFilters()
  Toprater.Hints.attachTo document
  Toprater.Subscriber.attachTo "[role=subscriber]"
  Toprater.CriteriaRating.attachTo "[role=criteria-rating]"
  Toprater.ReviewForm.attachTo "[role=review-form]"
  Toprater.IntroSlider.attachTo "[role=intro-slider]"
  Toprater.FWIntroSlider.attachTo "[role=fw-intro-slider]"

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
  Toprater.EmployersShareWidget.attachTo "[role=share-widget]"
