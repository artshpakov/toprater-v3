# example of filter component
# put filter template to app/views/partials/filters/specific

# sampleFilter = ->
#   @updateValues = (event, data) ->
#     @$node.find('select').val(data.value) # UI reaction on data update

#   @setValue = (event) ->
#     @attr.value = $(event.currentTarget).val() # set data from UI

#   @resetFilter = ->
#     @$node.find('select').val(null) # reset UI

#   @after 'initialize', ->
#     @on @$node.find('select'), 'change', @setValue # input change event

# Toprater.SampleFilter = flight.component(sampleFilter, Toprater.withFilterMixin)
