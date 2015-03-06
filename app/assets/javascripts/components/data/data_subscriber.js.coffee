dataSubscriber = ->
  @subscribe = (event, data) ->
    $.ajax
      url: window.location.href
      type: "POST"
      data: data

    .fail (data) =>
      @trigger document, "dataSubscribeError", error: data

    .done (data) =>
      @trigger document, "dataSubscribeDone", info: data


  @after "initialize", ->
    @on "uiSubscribeReq", @subscribe


Toprater.DataSubscriber = flight.component dataSubscriber
