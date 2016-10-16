FT.Views.Layout ||= {}

class FT.Views.Layout.AppLayout extends FT.Views.Layout.ViewManager
  el: 'body'

  constructor: (options) ->
    super options

  setView: (selector, view) ->
    super(selector, view)

  renderMain: (options) ->
    if @searchBarView
      @searchBarView.viewModel.clearResults()
    else
      @_renderSearchBar()

    @_renderMainNavbar()

    if options.main
      @setView("#app-wrapper-content", options.main)

    if options.secondary
      @_renderSecondaryNavigation options

  _renderSearchBar: ->
    unless @searchBarView
      @searchBarView = new FT.Views.Widgets.SearchBar
        viewModel: new FT.ViewModels.Widgets.SearchBar

      @setView '#search-bar', @searchBarView

  _renderMainNavbar: ->
    unless @mainNavbar
      @mainNavbar = new FT.Views.Widgets.Navbar
        viewModel: new FT.ViewModels.Widgets.Navbar

      @setView '#left-sidebar', @mainNavbar

  _renderSecondaryNavigation: (options) ->
    secondary = options.secondary
    unless @secondaryNavigation?.constructor.name == secondary.identifier
      @secondaryNavigation = new FT.Views[secondary.className]
        viewModel: new FT.ViewModels[secondary.className]
          mainViewModel: options.main.viewModel

      @setView '#secondary-navigation', @secondaryNavigation
