Toprater.attachFilters = ->
  Toprater.EnumFilter.attachTo "[role=enum-filter]"
  Toprater.RangeFilter.attachTo "[role=range-filter]"
  Toprater.StarsFilter.attachTo "[role=stars-filter]"
  Toprater.YearsFilter.attachTo "[role=years-filter]"

Toprater.attachDataComponents = ->
  Toprater.AppState.attachTo document
  Toprater.Results.attachTo "[role=objects-list]"
  Toprater.Router.attachTo document

Toprater.attachUIComponents = ->
  Toprater.Cart.attachTo "[role='cart']"
  Toprater.Criteria.attachTo "[role=criteria]"
  Toprater.Criterion.attachTo "[role=criterion]"
  Toprater.Search.attachTo "[role=search]"
  Toprater.PricesCalendar.attachTo "[role=prices-calendar]"
  Toprater.PricesTable.attachTo "[role=prices-table]"
  Toprater.Card.attachTo "[role=card]"
  Toprater.FilterReset.attachTo "[role=reset-filters]"
  Toprater.ObjectsList.attachTo "[role=objects-list]"
  Toprater.Reviews.attachTo "[role=reviews]"
  Toprater.attachFilters()

