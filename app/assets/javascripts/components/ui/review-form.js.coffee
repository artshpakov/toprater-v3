reviewForm = ->
  attr:
    object: ''
    criterion: ''

  @after "initialize", ->
    @attr.object    = @$node.data('object')
    @attr.criterion = @$node.data('criterion')

    @on @$node.find('select'), 'change', (event) ->
      console.log $(event.currentTarget).val()
      @trigger 'uiRatingSelected', { object: @attr.object, criterion: @attr.criterion, rating: $(event.currentTarget).val() }

    @on @$node.find('button'), 'click', (event) ->
      if @$node.find('textarea').val().length > 10
        @trigger 'uiReviewWritten', { object: @attr.object, criterion: @attr.criterion, review: @$node.find('textarea').val() }

    @on document, 'dataRatingSaved', ->
      console.log 'Rating saved'

    @on document, 'dataReviewSaved', ->
      console.log "Thanks for your review! It's very important for us."


Toprater.ReviewForm = flight.component reviewForm
