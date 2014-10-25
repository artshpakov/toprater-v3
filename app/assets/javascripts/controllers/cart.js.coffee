Toprater.CartCtrl = new Vue
  el: '[role=cart]'

  data:
    criteria: Toprater.State.criteria

  methods:
    drop: (criterionName) ->
      criterion = Toprater.Criterion.find criterionName
      Toprater.State.dropCriterion criterion if criterion?
      @criteria = Toprater.State.criteria

  ready: ->
    if criteria = location.search.split('criteria=')[1] # TODO refactor
      criteria = JSON.parse decodeURIComponent criteria

      _.defer ->
        for criterionName in criteria
          criterion = Toprater.Criterion.find criterionName
          Toprater.State.pickCriterion criterion if criterion?

    _.defer =>
      @$watch 'criteria.length', (count) ->
        Toprater.Alternative.rate()
        History.pushState null, "List", "/en/hotels/objects?#{ Toprater.State.toUrl() }"
