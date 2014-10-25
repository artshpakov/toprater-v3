class Toprater.Alternative extends Toprater.Model

  @url: "/en/hotels/objects"

  @rate: ->
    $('#rating').html "loading..."
    @query Toprater.State.parameterize(), (alternatives) ->
      $('#rating').replaceWith alternatives
