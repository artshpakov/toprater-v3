Toprater.filterToUrl = (name, value) ->
  encoders = {}

  encoders['numeric'] = (value) ->
    if value['from'] == value['to']
      value['from']
    else
      "#{value['from']}-#{value['to']}"

  encoders['string'] = (value) ->
    value

  encoders['multi_string'] = (value) ->
    value.join(',')

  if settings = toprater.filters[name]
    url = "/#{settings.name}/"
    url += encoders[settings.kind](value)
    url
  else ''

Toprater.isMultiFilter = (name) ->
  toprater.filters[name].kind.indexOf('multi') > -1
