#= require jquery
#= require jquery_ujs
#= require foundation
#= require vendor/modernizr
#= require underscore
#= require vue
#= require history_jquery_html5

#= require_self
#= require_tree ./utils
#= require_tree ./services
#= require_tree ./models
#= require_tree .


$ -> $(document).foundation()

window.Toprater ?= {}
