class Toprater.Alternative extends Toprater.Model

  @url: "/en/hotels/alternatives"

  @rate: ->
    $('#rating').html "loading..."
    @query p: Toprater.State.parameterize(), (alternatives) ->
      $('#rating').html alternatives
