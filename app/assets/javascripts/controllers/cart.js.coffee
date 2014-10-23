Toprater.CartCtrl = new Vue
  el: '[role=cart]'

  data:
    criteria: Toprater.State.criteria

  ready: ->
    @$watch 'criteria.length', ->
      Toprater.Alternative.rate()
