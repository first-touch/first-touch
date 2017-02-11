#= require jquery
#= require jquery_ujs
#= require hamlcoffee
#= require js-cookie
#= require knockout
#= require lodash/lodash.js
#= require moment
#= require tether
#= require bootstrap
#= require_self
#= require_tree .

@FT =
  App: {}
  Views: {}
  ViewModels: {}
  DataModels: {}
  Routers: {}

@templateFor = (templatePath) ->
  JST[templatePath]
