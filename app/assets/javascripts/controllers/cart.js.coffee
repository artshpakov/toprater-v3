Toprater.CartCtrl = new Vue
  el: '[role=cart]'

  data:
    criteria: Toprater.State.criteria

  ready: ->
    @$watch 'criteria.length', ->
      Toprater.Alternative.rate()
      History.pushState null, "List", "/en/hotels/objects?#{ Toprater.State.toUrl() }"
