dataSubscriber = ->
  @subscribe = (event, data) ->
    $.ajax
      url: "/subscribe"
      type: "POST"
      data: data

    .fail (data) =>
      if data.responseJSON?
        if data.responseJSON.email[0] == "only one subscribtion from source"
          @trigger document, "dataSubscribeError", alreadySubscribed: true
        else
          @trigger document, "dataSubscribeError", error: data
      else
        @trigger document, "dataSubscribeError", error: data

    .done (data) =>
      @trigger document, "dataSubscribeDone", info: data


  @after "initialize", ->
    @on "uiSubscribeReq", @subscribe


Toprater.DataSubscriber = flight.component dataSubscriber
