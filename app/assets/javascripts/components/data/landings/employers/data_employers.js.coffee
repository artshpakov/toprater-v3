dataEmployers = ->
  # @attributes

  @encode = (criteria, filters) ->
    paramsPath = ""

    if criteria?.length
      paramsPath += "/criteria/" + criteria.join(",")

    if filters?.length
      paramsPath += "/filters"
      paramsPath += filterToUrl(filter.name, filter.value) for filter in filters

    paramsPath


  @switchRating = (event, data) ->
    url = document.location.href + "/?"
    if data.dest == "worst"
      url += "reverse= true"

    $.ajax(
      url: url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorLoadingObjects", data
    )
    .done( (data) =>
      @trigger "employersRatingLoaded", objects: data
      # @trigger document, "pageUpdated"
    )





  @after "initialize", ->
    @on document, "ratingSwitched", @switchRating



Toprater.DataEmployers = flight.component dataEmployers
  
