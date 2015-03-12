dataSubscriber = ->
  @subscribe = (event, data) ->
    $.ajax
      url: window.location.href
      type: "POST"
      data: data

    .fail (data) =>
      console.log "ERROR"
      console.log data
      if data.responseJSON.email[0] == "only one subscribtion from source"
        @trigger document, "dataSubscribeError", alreadySubscribed: true
      else
        @trigger document, "dataSubscribeError", error: data

    .done (data) =>
      @trigger document, "dataSubscribeDone", info: data


  @after "initialize", ->
    @on "uiSubscribeReq", @subscribe


Toprater.DataSubscriber = flight.component dataSubscriber
