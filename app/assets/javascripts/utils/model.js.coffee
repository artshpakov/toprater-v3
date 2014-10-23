class Toprater.Model

  constructor: (attrs) ->
    _.extend @, attrs
    @initialize() if @initialize?

  query: (params, callback=null) =>
    if _.isFunction params
      callback  = params
      params    = {}
    $.get @url(), params, callback
