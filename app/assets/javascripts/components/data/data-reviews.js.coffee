dataReviews = ->

  @errorHandler = (data) =>
    if data.status == 401
      $('.anonymous a').first().click()
    else
      console.log 'Error loading', data

  @after 'initialize', ->
    @on 'uiRatingSelected', (event, data) ->
      $.ajax(
        url: "/en/#{toprater.state.sphere}/reviews/#{data.object}"
        method: 'POST'
        data:
          criterion: data.criterion
          rating: data.rating
      )
      .fail(@errorHandler)
      .done (data) =>
        @trigger 'dataRatingSaved'

    @on 'uiReviewWritten', (event, data) ->
       $.ajax(
         url: "/en/#{toprater.state.sphere}/reviews/#{data.object}"
         method: 'POST'
         data:
           criterion: data.criterion
           review: data.review
       )
       .fail(@errorHandler)
       .done (data) =>
         @trigger 'dataReviewSaved'

Toprater.DataReviews = flight.component dataReviews
