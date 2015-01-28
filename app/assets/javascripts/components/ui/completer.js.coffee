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
      limit: 10

    objectsEngine = new Bloodhound
      remote:
        url: "/#{toprater.state.sphere}/suggest/objects?q=%QUERY"
        filter: (list) ->
          $.map list, (item) -> { label: item.label, value: item.id }
      datumTokenizer: (d) ->
        Bloodhound.tokenizers.whitespace(d.value)
      queryTokenizer: Bloodhound.tokenizers.whitespace
      limit: 10

    engine.initialize()
    objectsEngine.initialize()

    @$node.find('#completer').tokenfield
      typeahead: [
        highlight: true
        , {
          name: 'objects'
          displayKey: 'label'
          source: objectsEngine.ttAdapter()
        }
        , {
          name: 'search'
          displayKey: 'label'
          source: engine.ttAdapter()
          templates:
            suggestion: (data) -> JST['suggestion'].render(data)
            header: "<hr/>"
        }
      ]

    @$node.find('#completer').on 'tokenfield:createtoken', (event) =>
      if typeof event.attrs.type == 'undefined'
        window.location.href = "/en/#{toprater.state.sphere}/objects/#{event.attrs.value}"
        return false

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
