auth = ->

  @after "initialize", ->
    
    @on 'ajax:success', ->
      window.location.reload()
    @on 'ajax:error', (event, response) ->
      $('[role=errors]', @$node).show().text response.responseText

Toprater.Auth = flight.component auth
