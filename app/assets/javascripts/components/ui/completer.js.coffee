# completer = ->
#   @changeCriterion = (token, picked) ->
#     @trigger "uiCriterionToggled", { name: token.value, label: token.label, picked: picked }

#   @after 'initialize', ->
#     engine = new Bloodhound
#       remote: 
#         url: "/#{toprater.state.sphere}/suggest?q=%QUERY"
#         filter: (list) ->
#           $.map list, (item) -> { label: item.label, value: item.name, type: item.type }
#       datumTokenizer: (d) ->
#         Bloodhound.tokenizers.whitespace(d.value)
#       queryTokenizer: Bloodhound.tokenizers.whitespace
#       limit: 10

#     objectsEngine = new Bloodhound
#       remote:
#         url: "/#{toprater.state.sphere}/suggest/objects?q=%QUERY"
#         filter: (list) ->
#           $.map list, (item) -> { label: item.label, value: item.id }
#       datumTokenizer: (d) ->
#         Bloodhound.tokenizers.whitespace(d.value)
#       queryTokenizer: Bloodhound.tokenizers.whitespace
#       limit: 10

#     engine.initialize()
#     objectsEngine.initialize()

#     @$node.find('#completer').typeahead
#       highlight: true
#       , {
#         name: 'objects'
#         displayKey: 'label'
#         source: objectsEngine.ttAdapter()
#       }
#       , {
#         name: 'search'
#         displayKey: 'label'
#         source: engine.ttAdapter()
#         templates:
#           suggestion: (data) -> JST['suggestion'].render(data)
#           header: "<hr/>"
#       }

#     @$node.find('#completer').on 'typeahead:selected', (event, item, dataset) =>
#       if dataset == 'objects'
#         window.location.href = "/en/#{toprater.state.sphere}/objects/#{item.value}"
#       if item.type == 'criteria'
#         @changeCriterion item, true
#       else
#         @trigger "uiFiltersChanged", { name: item.type, filterName: item.type, value: item.value }
#       $(event.currentTarget).val('')

# Toprater.Completer = flight.component completer
