slideNav = ->
  @attributes
    slides: []

  @renderNav = ->
    @$node.html JST['slider_nav'].render { slides: @attr.slides }

  @registerSlide = (event, data) ->
    @attr.slides.push +data.number
    @renderNav()

  @navigate = (event) ->
    event.stopPropagation()
    if event.target.tagName.toLowerCase() == "a"
      @trigger document, "slideScrollReq", number: +event.target.getAttribute "data-number"


  @after "initialize", ->
    @on document, "slideInitialized", @registerSlide

    @on @$node, "click", @navigate

Toprater.SlideNav = flight.component slideNav
