#= require jquery
#= require jquery_ujs
#= require foundation
#= require vendor/modernizr
#= require underscore
#= require history_jquery_html5
#= require es5-shim/es5-shim-min
#= require flight-for-rails

#= require_self
#= require_tree ./utils
#= require_tree ./mixins
#= require_tree ./components
#= require_tree .


$ -> $(document).foundation()

window.Toprater ?= {}
