dataEmployers = ->
  @attributes
    rating: "best"

  @switchRating = (event, data) ->
    url = document.location.href + "/?"
    if data.dest == "worst"
      url += "inverse=true"
      @attr.rating = "worst"

    $.ajax(
      url: url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingObjects", data
    )
    .done( (data) =>
      @trigger document, "employersRatingLoaded", type: @attr.rating, objects: data
    )


  @after "initialize", ->
    @on document, "ratingSwitched", @switchRating



Toprater.DataEmployers = flight.component dataEmployers
  
