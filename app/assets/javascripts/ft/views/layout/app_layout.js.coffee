FT.Views.Layout ||= {}

class FT.Views.Layout.AppLayout extends FT.Views.Layout.ViewManager
  el: 'body'

  constructor: (options) ->
    super options

  setView: (selector, view) ->
    super(selector, view)

  renderMain: (options) ->
    if options.main
      @setView("#app-wrapper-content", options.main)
