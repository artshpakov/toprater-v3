completerResult = ->
  @attributes
    data: []

  @loadResult = (event, data) ->
    $.ajax(
      url: "/#{toprater.state.sphere}/suggest"
      data:
        q: data.query
      method: 'GET'
    ).done (data) =>
      @trigger 'dataSuggestionLoaded', { payload: data }

  @after 'initialize', ->
    @on 'uiSuggestionRequested', _.debounce(@loadResult, 300)

Toprater.CompleterResults = flight.component completerResult
