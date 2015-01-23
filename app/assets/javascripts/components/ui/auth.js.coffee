auth = ->

  @after "initialize", ->
    @on 'ajax:error', (event, response) ->
      $('[role=errors]', @$node).show().text response.responseText

Toprater.Auth = flight.component auth
