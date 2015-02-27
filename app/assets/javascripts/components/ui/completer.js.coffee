completer = ->
  @changeCriterion = (token, picked) ->
    @trigger "uiCriterionToggled", { name: token.value, label: token.label, picked: picked }

  @moveLeft = ->
    current = @$node.find('.token.active')
    unless current.length
      @$node.find('.token:last').addClass('active')
    else
      current.removeClass('active')
      current.prev().addClass('active')

  @moveRight = ->
    current = @$node.find('.token.active')
    unless current.length
      @$node.find('.token:first').addClass('active')
    else
      current.removeClass('active')
      current.next().addClass('active')

  @moveDown = ->
    current = @$node.find('ul.suggestions li.active')
    if current.length == 0
      @$node.find('ul.suggestions li:first').addClass('active')
      return
    current.removeClass('active')
    current.next().addClass('active')

  @moveUp = ->
    current = @$node.find('ul.suggestions li.active')
    if current.length == 0
      @$node.find('ul.suggestions li:last').addClass('active')
      return
    current.removeClass('active')
    current.prev().addClass('active')


  @after 'initialize', ->
    @$node.find('#completer').on 'keyup', (event) =>
      val = $(event.currentTarget).val()
      if val.length == 0
        $('.completer-result').html('')
      switch event.keyCode
        when 8   # backspace
          if val.length == 0
            current = @$node.find('.token.active')
            unless current.length
              current = @$node.find('.token:last').addClass('active')
            else
              current.click()
          return
        when 13
          current = @$node.find('ul.suggestions li.active')
          if current.length > 0
            current.click()
          return
        when 37  # left
          @moveLeft() if val.length == 0
          return
        when 38  # up
          @moveUp()
          return
        when 39  # right
          @moveRight() if val.length == 0
          return
        when 40  # down
          @moveDown()
          return
        # when 65  # ctrl+a
        #   @selectAll()

      $(event.currentTarget).attr('size', _.max([val.length+2, 12]))
      if val.length > 1
        @trigger 'uiSuggestionRequested', { query: val }


    @$node.find('.completer-result').on 'click', 'li', (event) =>
      id = $(event.currentTarget).data('id')
      type = $(event.currentTarget).data('type')
      if type == 'objects'
        window.location.href = "/en/#{toprater.state.sphere}/objects/#{id}"
      if type == 'criteria'
        @trigger "uiCriterionToggled", { name: id, label: id, picked: true }
      else
        @trigger "uiFiltersChanged", { name: type, filterName: type, value: id }
      @$node.find('.completer-result').html('')
      @$node.find('#completer').val('')

    @$node.find('.completer-result').on 'mouseover', 'ul.suggestions li', (event) ->
      $(event.currentTarget).addClass('active')

    @$node.find('.completer-result').on 'mouseout', 'ul.suggestions li', (event) ->
      $(event.currentTarget).removeClass('active')


    @on document, 'dataSuggestionLoaded', (event, data) ->
      $('.completer-result').html JST['suggestion'].render(data)


Toprater.Completer = flight.component completer
