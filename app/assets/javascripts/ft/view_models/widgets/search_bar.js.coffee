FT.ViewModels.Widgets ||= {}

class FT.ViewModels.Widgets.SearchBar extends FT.ViewModels.Base
  constructor: ->
    super()
    @searchContents = ko.observable()
    @searchResults = ko.observableArray()

    @displayResults = ko.pureComputed =>
      @searchResults().length > 0

    @_subscribe @searchContents, @quickQuery

  search: ->
    console.log @searchContents()

  quickQuery: =>
    if _.isEmpty @searchContents()
      @searchResults []
    else
      @getResults()
      # TODO: query api endpoint and update results
      console.log @searchContents()

  getResults: ->
    # TODO: Find a way of integrating this with
    # DataModels
    searchResultsPromise = (=>
      ajaxCall = $.ajax
        type: 'GET'
        dataType: 'json'
        url: 'api/v1/search'
        data: { 'q': @searchContents() }

      ajaxCall.done (response) ->
        Promise.resolve response

      ajaxCall.fail (xhr) ->
        console.log xhr
        errorMessage = "Failed to make changes on the server"
        Promise.reject errorMessage
    )()

    searchResultsPromise.then (searchResults) =>
      @searchResults _.map searchResults.users, (result) ->
        new SearchResult result

  clearResults: ->
    @searchContents ''

class SearchResult
  constructor: (options) ->
    @name = ko.observable options.display_name
    @profileUrl = ko.observable "#users/#{options.id}"
    # TODO: Load profile image as well
