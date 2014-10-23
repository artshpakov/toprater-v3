class Toprater.Alternative extends Toprater.Model

  @url: "/alternatives"

  @rate: ->
    $('#rating').html "loading..."
    @query p: Toprater.State.parameterize(), (alternatives) ->
      $('#rating').html alternatives
