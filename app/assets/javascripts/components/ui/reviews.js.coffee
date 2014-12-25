reviews = ->

  @pickReviewsPack = (event) ->
    console.log 'pickPack'
    name = $(event.target).data('name')
    @$node.find(".criterion").removeClass('current')
    @$node.find("[data-name=#{ name }]").addClass('current')
    @$node.find("[data-criterion]").hide()
    @$node.find("[data-criterion=#{ name }]").show()

  @reload = ->
    console.log 'reload'
    Toprater.Reviews.attachTo "[role=reviews]"

  @after "initialize", ->
    @on @$node.find('.criterion'), 'click', @pickReviewsPack
    @on document, "pageUpdated", @reload
    @trigger @$node.find('.criterion').eq(0), 'click'

Toprater.Reviews = flight.component reviews

