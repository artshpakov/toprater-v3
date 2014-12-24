# example of filter component
# put filter template to app/views/partials/filters/specific

# sampleFilter = ->
#   @defaultAttrs
#     name: ''              # filter's API-name
#     value: {}

#   @after 'initialize', ->
#     @attr.name = @$node.attr('data-name')

#     @on document, "#{@attr.name}Updated", (event, data) ->
#       # [ ... UI update logic here ... ]
#       @attr.value = data.value

#     @on document, 'filtersReset', ->
#       # [ ... UI reset logic here ... ]
#       @attr.value = {}

#     # [ ... some other component logic ... ]

# Toprater.SampleFilter = flight.component(sampleFilter)
# Toprater.SampleFilter.attachTo "[role=sample-filter]"
