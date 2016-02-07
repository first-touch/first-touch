#= require jquery
#= require jquery_ujs
#= require hamlcoffee
#= require js-cookie
#= require knockout
#= require lodash/lodash.js
#= require tether/dist/js/tether
#= require bootstrap
#= require fullpage.js/jquery.fullPage.js
#= require_self
#= require_tree .

@FT =
  App: {}
  Views: {}
  ViewModels: {}
  Routers: {}

@templateFor = (templatePath) ->
  JST[templatePath]
