FT.ViewModels.Widgets ||= {}

class FT.ViewModels.Widgets.Navbar extends FT.ViewModels.Base
  constructor: ->
    super()
    @userName = ko.observable()
    @currentStatus = ko.observable()
    @currentClub = ko.observable()

    @triggerLoad()

  currentPage: (id) ->
    FT.App.currentUrlClass id

  _load: ->
    FT.App._currentUserInitialized.then (user) =>
      personalProfile = user.personal_profile
      @userName([personalProfile.first_name, personalProfile.last_name].join ' ')
      @currentStatus 'unemployed'
      @currentClub 'N/A'
