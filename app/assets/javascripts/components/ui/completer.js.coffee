completer = ->
  @changeCriterion = (token, picked) ->
    @trigger "criterionToggled", { name: token.value, label: token.label, picked: picked }

  @after 'initialize', ->
    engine = new Bloodhound
      remote: 
        url: "/#{toprater.state.sphere}/suggest?q=%QUERY"
        filter: (list) ->
          $.map list, (item) -> { label: item.label, value: item.name, type: item.type }
      datumTokenizer: (d) ->
        Bloodhound.tokenizers.whitespace(d.value)
      queryTokenizer: Bloodhound.tokenizers.whitespace
      limit: 15

    objectsEngine = new Bloodhound
      remote: 
        url: "/objects/suggest?q=%QUERY"
        # filter: (list) ->
        #   $.map list, (item) -> { label: item.label, value: item.name, type: item.type }
      datumTokenizer: (d) ->
        Bloodhound.tokenizers.whitespace(d.id)
      queryTokenizer: Bloodhound.tokenizers.whitespace
      limit: 15

    engine.initialize()

    @$node.find('#completer').tokenfield
      typeahead: [
        highlight: true
        , {
          name: 'search'
          displayKey: 'label'
          source: engine.ttAdapter()
          templates:
            suggestion: (data) -> JST['suggestion'].render(data)
        }, {
          name: 'objects'
          displayKey: 'label'
          source: objectsEngine.ttAdapter()
        }
      ]

    @$node.find('#completer').on 'tokenfield:createdtoken', (event) =>
      token = event.attrs
      if token.type == 'criteria'
        @changeCriterion token, true
      else
        @trigger "filtersChanged", { name: token.type, filterName: token.type, value: token.value }

    @$node.find('#completer').on 'tokenfield:removedtoken', (event) =>
      token = event.attrs
      if token.type == 'criteria'
        @changeCriterion token, false
      else
        @trigger "filterReset", { filter: token.type }

Toprater.Completer = flight.component completer
