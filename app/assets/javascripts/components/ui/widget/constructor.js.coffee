widgetConstructor = ->

  render = ->
    $('[role=widget-code]').text JST['widget_code'].render
      id: toprater.id
      criteria: JSON.stringify(toprater.state.criteria)
      filters: JSON.stringify(toprater.state.filters)
      scheme: $('[name=scheme]:checked').val()
      hash: toprater.hash
      type: 1
      hotelLink: toprater.currentHotelLink
      hotelName: toprater.currentHotelName
    options =
      criteria: toprater.state.criteria
      filters: toprater.state.filters
      scheme: $('[name=scheme]:checked').val()
      type: 1
    # TODO use proper endpoint
    $('[role=widget-preview]').attr 'src', "http://5.9.0.5/widget/#{ toprater.id }?p=#{ JSON.stringify options }"

  @after "initialize", ->
    render()
    $('form', @$node).on 'change', render


Toprater.WidgetConstructor = flight.component widgetConstructor
