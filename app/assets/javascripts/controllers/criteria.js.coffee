Toprater.CriteriaCtrl = new Vue
  el: '[role=criteria]'


  methods:
    display: (section) ->
      @current = section

    pick: (name) ->
      criterion = Toprater.Criterion.find name
      Toprater.State.pickCriterion criterion


  Toprater.Criterion.items = toprater.criteria.map (attrs) ->
    new Toprater.Criterion attrs
