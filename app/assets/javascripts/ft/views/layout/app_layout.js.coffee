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

    if options.main
      @setView("#app-wrapper-content", options.main)

  _renderSearchBar: ->
    unless @searchBarView
      @searchBarView = new FT.Views.Widgets.SearchBar
        viewModel: new FT.ViewModels.Widgets.SearchBar

    @setView '#search-bar', @searchBarView
