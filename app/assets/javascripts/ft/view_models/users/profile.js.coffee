FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.Profile extends FT.ViewModels.Base
  constructor: ->
    super()

    @id = ko.observable()
    @email = ko.observable()
    @firstName = ko.observable()
    @lastName = ko.observable()

    @triggerLoad()

  _load: ->
    FT.App.ApiClient.get("api/v1/users/#{FT.App._currentUserId()}", @_loadUserProfile)

  _loadUserProfile: (userModel) =>
    @id userModel.id
    @email userModel.email
    @firstName userModel.first_name
    @lasttName userModel.last_name
