nextSlide = ->

    @after "initialize", ->
      @on "click", ->
        @trigger document, "nextSlide"


  Toprater.NextSlide = flight.component nextSlide
