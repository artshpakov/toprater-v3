search = ->
  @attributes
    url: "/en/movies/search.json?term="

  @getObjects = (event) ->
    url = @attr.url + @$node.find("input#search").val()

    @$node.find("input#search").val()

    $.ajax(
      url: url
      method: "GET"
    )
    .fail( (data) =>
      console.log data
    )
    .done( (data) =>
      _.each data.objects, (object) ->
      @$node.find(".result").append "<a href='/en/landings/similar/#{ object }'>#{ object.id }</a>"
    )


  @after "initialize", ->
    @on @$node.find("input#search"), "keyup", @getObjects

Toprater.Search = flight.component(search)
