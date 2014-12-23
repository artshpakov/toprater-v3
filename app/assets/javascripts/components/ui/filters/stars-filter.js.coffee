starsFilter = ->
  @defaultAttrs
    name: ''
    value: {}

  @after 'initialize', ->
    @attr.name = @$node.attr('data-name')

    @on document, "#{@attr.name}Updated", (event, data) ->
      console.log data
      @$node.find("#stars-#{data.value}").attr('checked', true)
      @attr.value = data.value

    @on "[role=stars-radio]", 'click', (event) ->
      @attr.value = $(event.currentTarget).val()
      @trigger 'filtersChanged', @attr

    @on document, 'filtersReset', ->
      @$node.find("[role=stars-radio]").attr('checked', false)
      @attr.value = {}

Toprater.StarsFilter = flight.component(starsFilter)
Toprater.StarsFilter.attachTo "[role=stars-filter]"
