introSlider = ->
  @attributes
    dots: false
    infinite: true
    speed: 300
    variableWidth: true
    slidesToShow: 3
    slidesToScroll: 1
    responsive: [
      breakpoint: 1239
      settings:
        slidesToShow: 2
        slidesToScroll: 1
      breakpoint: 830
      settings:
        slidesToShow: 1
        slidesToScroll: 1
    ]
    


  @after "initialize", ->
    @before "attach", ->
      @attr.prevArrow = @$node.parent().parent().find ".arrows-block .left-arrow"
      @attr.nextArrow = @$node.parent().parent().find ".arrows-block .right-arrow"
    # @after "attach", ->
    #   @$node.find(".slick-prev").addClass("left-arrow, toprater-icon-chevron-left")
    #   @$node.find(".slick-next").addClass("right-arrow, toprater-icon-chevron-right")
    #   @$node.find(".slick-prev, .slick-next").appendTo @$node.find(".arrows-block")



Toprater.IntroSlider = flight.component introSlider, Toprater.WithCarouselMixin
