#= require jquery
#= require jquery_ujs
#= require foundation
#= require nprogress
#= require vendor/modernizr
#= require underscore
#= require history_jquery_html5
#= require director
#= require flight-for-rails
#= require hogan.js
#= require intro.js
#= require Chart

#= require_self
#= require_tree ./templates
#= require_tree ./utils
#= require_tree ./mixins
#= require_tree ./components
#= require loaders
#= require_tree .

# Uncomment to debug FlightJS
# flight.debug.enable true
# DEBUG.events.logAll()

$ ->
  # TODO: automate this
  _kmq.push(["set", {"Show Actors": toprater.ab.actors.show}])
  _kmq.push(["set", {"Reviews color": toprater.ab.reviews.color}])

  $(document).on 'ajaxStart', -> NProgress.start()
  $(document).on 'ajaxStop', -> NProgress.done()

  $(document).foundation()
  
  Toprater.attachUIComponents()
  Toprater.attachDataComponents()

window.Toprater ?= {}
