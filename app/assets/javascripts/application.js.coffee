#= require jquery
#= require jquery_ujs
#= require foundation
#= require nprogress
#= require vendor/modernizr
#= require underscore
#= require history_jquery_html5
#= require director
#= require es5-shim/es5-shim-min
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
  $(document).on 'ajaxStart', -> NProgress.start()
  $(document).on 'ajaxStop', -> NProgress.done()

  $(document).foundation()
  
  Toprater.attachUIComponents()
  Toprater.attachDataComponents()

window.Toprater ?= {}
