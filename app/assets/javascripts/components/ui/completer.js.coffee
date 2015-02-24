completer = ->

  @changeCriterion = (token, picked) ->
    @trigger "uiCriterionToggled", { name: token.value, label: token.label, picked: picked }

  @after 'initialize', ->
    @$node.find('#completer').on 'keyup', (event) =>
      val = $(event.currentTarget).val()
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

    @on document, 'dataSuggestionLoaded', (event, data) ->
      $('.completer-result').html JST['suggestion'].render(data)


Toprater.Completer = flight.component completer
