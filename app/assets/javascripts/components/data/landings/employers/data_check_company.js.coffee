dataCheckCompany = ->


  # @encode = (criteria, filters) ->
  #   paramsPath = ""

  #   if criteria?.length
  #     paramsPath += "/criteria/" + _.pluck(criteria, "name").join(",")

  #   if filters?.length
  #     paramsPath += "/filters"
  #     paramsPath += Toprater.filterToUrl(filter.name, filter.value) for filter in filters

  #   paramsPath


  @searchResult = (event, search) ->
    url =  "/en/companies/search.json?term=#{ search.term }"

    $.ajax(
      url: url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorSearchEmployers", data
    )
    .done( (data) =>
      @trigger @$node, "employersSearchLoaded", { result: data.objects }
    )


  @getResult = (event, data) ->
    url =  window.location.href + data.id

    $.ajax(
      url: url
      method: "GET"
    )
    .fail( (data) =>
      @trigger "errorCheckEmployer", data
    )
    .done( (data) =>
      @trigger @$node, "employerLoaded", 
        employer: data.employer
        find_company_title: data.find_company_title
        check_company_title: data.check_company_title
    )



  @after "initialize", ->
    @on @$node, "findEmployerReq", @searchResult

    @on @$node, "checkEmployerResultsReq", @getResult



Toprater.DataCheckMechanic = flight.component dataCheckCompany
