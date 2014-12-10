# class Toprater.Model

#   constructor: (attrs) ->
#     _.extend @, attrs
#     @initialize() if @initialize?

#   @query: (params, callback=null) ->
#     if _.isFunction params
#       callback  = params
#       params    = {}
#     url = if _.isFunction @url then @url() else @url
#     $.get url, params, callback
