subscriber = ->
  @attributes
    localForm: "form"
    input: "input"
    button: "button"


  @validateEmail = (email) -> 
    re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    re.test email

  @subscribe = (event) ->
    event.preventDefault()
    email = @select("input").val()
    if email != '' and @validateEmail(email)
      $.ajax
          url: 'https://docs.google.com/a/sentimeta.com/forms/d/1A4_6XGEfN_UhdD9Y7Y4Ly4ut5NAmB6aVbkD400t9ok0/formResponse'
          data:
            'entry.1846300053': email
          type: 'GET'
          crossDomain: "true"
          dataType: 'jsonp'
      .complete (event, xhr, data) ->
        console.log event
        console.log xhr
        console.log data
        if $(event.responseText).find '.ss-resp-message'
          @$node.find('.form-group').removeClass '.has-error'
          @select("localForm").html '<div class="success">You have been subscribed!</div>'
          @$node.find('.email-error').remove()
    else
      @$node.find('.email-error').remove()
      @$node.append $('<span class="email-error">E-mail is not valid</span>')


  @after "initialize", ->
    @on @$node.find("button"), "click", @subscribe
    @on @$node.find("form"), "submit", @subscribe




Toprater.Subscriber = flight.component subscriber
