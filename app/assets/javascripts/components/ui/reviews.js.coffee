reviews = ->

  @after "initialize", ->

    @pickReviewsPack = (name) ->
      @$node.find(".criterion").removeClass('current')
      @$node.find("[data-name=#{ name }]").addClass('current')
      @$node.find("[data-criterion]").hide()
      @$node.find("[data-criterion=#{ name }]").show()

    @pickReviewsPack @$node.find('.criterion').eq(0).data('name')

    @on @$node.find('.criterion'), 'click', (event) =>
      @pickReviewsPack $(event.target).data('name')

    @on document, "pageUpdated", ->
      Toprater.Reviews.attachTo "[role=reviews]"


Toprater.Reviews = flight.component reviews
Toprater.Reviews.attachTo "[role=reviews]"
