#= require jquery
#= require jquery_ujs
#= require foundation
#= require vendor/modernizr
#= require underscore
#= require vue

#= require_self
#= require_tree ./utils
#= require_tree ./services
#= require_tree ./models
#= require_tree .


$ -> $(document).foundation()

window.Toprater ?= {}
