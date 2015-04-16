subscriber = ->
  @attributes
    localForm: "form"
    input: "input"
    button: "button"


  @validateEmail = (email) -> 
    re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    re.test email

  @subscribe = (event) ->
    event.stopPropagation()
    event.preventDefault()
    email = @select("input").val()
    @$node.find(".subscriber-error").remove()
    if email != ''
      if @validateEmail(email)
        @trigger document, "uiSubscribeReq", email: email
      else
        @select("input").after("<div class='subscriber-error'>Email is not valid</div>").show(500)
        _.delay(=> @$node.find(".subscriber-error").hide()
                ,
                20000
                )




  @error = (event, data) ->
    if data.alreadySubscribed
      @select("input").after("<div class='subscriber-info'>You are already subscribed.</div>").show(500)
      _.delay(=> @$node.find(".subscriber-info").hide()
              ,
              20000
              )
    else  
      @select("input").after("<div class='subscriber-error'>Error while saving your e-mail</div>").show(500)
      _.delay(=> @$node.find(".subscriber-error").hide()
              ,
              20000
              )


  @done = (event, data) ->
    @select("localForm").find("input, button, label").hide()
    @select("localForm").html("<div class='subscriber-success'>Thank you! Stay tuned!</div>")


  @after "initialize", ->
    @on @$node.find("button"), "click", @subscribe
    @on @$node.find("form"), "submit", @subscribe
    @on @$node.find("input[type=text]"), "keyup", ->
      if @$node.find("input[type=text]").val().length > 0
        @select("button").addClass "active"
      else
        @select("button").removeClass "active"  

    @on document, "dataSubscribeError", @error
    @on document, "dataSubscribeDone", @done



Toprater.Subscriber = flight.component subscriber
