fullWidthIntroSlider = ->
  @attributes
    dots: false
    infinite: true
    speed: 300
    variableWidth: true
    slidesToShow: 5
    slidesToScroll: 1
    responsive: [
      breakpoint: 1600
      settings:
        slidesToShow: 4
        slidesToScroll: 1
      breakpoint: 1280
      settings:
        slidesToShow: 3
        slidesToScroll: 1
      breakpoint: 953
      settings:
        slidesToShow: 2
        slidesToScroll: 1
      breakpoint: 640
      settings:
        slidesToShow: 1
        slidesToScroll: 1
    ]
    


  @after "initialize", ->
    @before "attach", ->
      @attr.prevArrow = @$node.parent().parent().find ".arrows-block .left-arrow"
      @attr.nextArrow = @$node.parent().parent().find ".arrows-block .right-arrow"


Toprater.FWIntroSlider = flight.component fullWidthIntroSlider, Toprater.WithCarouselMixin
