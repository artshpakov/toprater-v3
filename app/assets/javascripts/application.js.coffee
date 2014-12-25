#= require jquery
#= require jquery_ujs
#= require foundation
#= require vendor/modernizr
#= require underscore
#= require history_jquery_html5
#= require director
#= require es5-shim/es5-shim-min
#= require flight-for-rails
#= require hogan.js

#= require_self
#= require_tree ./utils
#= require_tree ./mixins
#= require_tree ./components/ui
#= require_tree ./components/data
#= require_tree .

# Uncomment to debug FlightJS
# flight.debug.enable(true);
# DEBUG.events.logAll();

$ -> $(document).foundation()

window.Toprater ?= {}
