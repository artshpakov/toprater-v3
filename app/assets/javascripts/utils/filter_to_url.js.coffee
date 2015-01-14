window.filterToUrl = (name, value) ->
  encoders = {}

  encoders['numeric'] = (value) ->
    if value['from'] == value['to']
      value['from']
    else
      "#{value['from']}-#{value['to']}"

  encoders['string'] = (value) ->
    value

  settings = toprater.filters[name]
  url = "/#{settings.name}/"
  url += encoders[settings.kind](value)
  url
