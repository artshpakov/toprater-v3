withCarousel = ->
  @attributes
    dots: false
    infinite: true
    speed: 300
    variableWidth: true

  @attach = ->
    @$node.slick(@attr)

  @after "initialize", ->
    @attach()




Toprater.WithCarouselMixin = withCarousel
