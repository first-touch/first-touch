FT.Views.Layout ||= {}

class FT.Views.Layout.ViewManager extends FT.Views.Base
  constructor: (options) ->
    super options
    @$el = $(@el)
    @views ||= {}

  setView: (selector, view) ->
    existingView = @getView selector
    existingView.remove() if existingView

    @views[selector] = view

    if @$el.find(selector).length > 0
      @$el.find(selector).html view.render().$el
    else
      throw "OPL.Views.ViewManager - setView selector: #{selector} - not found"

  getView: (selector) ->
    @views[selector]

  removeView: (selector) ->
    @getView(selector)?.unbind()
    @getView(selector)?.remove()
    delete @views[selector]

  remove: ->
    for view in @views
      view.remove()
    super()
