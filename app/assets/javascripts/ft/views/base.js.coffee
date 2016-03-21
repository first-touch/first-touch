class FT.Views.Base
  constructor: (options) ->
    if this.el?
      @$el = $(this.el)
    else
      @$el = $('<div></div>')

    @viewModel = options.viewModel if options?.viewModel

  render: ->
    @$el.html @template
    ko.applyBindings @viewModel, @$el[0]
    @

  remove: ->
    ko.cleanNode @$el[0]
    @$el.remove()
