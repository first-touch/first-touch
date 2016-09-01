FT.ViewModels.Widgets ||= {}

class FT.ViewModels.Widgets.Navbar extends FT.ViewModels.Base
  constructor: ->
    super()

  currentPage: (id) ->
    FT.App.currentUrlClass id
