FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.Profile extends FT.ViewModels.Base
  constructor: ->
    super()

    @id = ko.observable()
    @email = ko.observable()
    @firstName = ko.observable()
    @lastName = ko.observable()
    @displayName = ko.pureComputed =>
      "#{@firstName()} #{@lastName()}"
    @nationality = ko.observable()
    @birthday = ko.observable()
    @displayBirthday = ko.pureComputed =>
      @birthday()?.format(FT.Dictionaries.TimeFormats.Date) || ''
    @age = ko.pureComputed =>
      moment().diff(@birthday(), 'years')

    @triggerLoad()

  _load: ->
    FT.App.ApiClient.get("api/v1/users/#{FT.App._currentUserId()}", @_loadUserProfile)

  _loadUserProfile: (userModel) =>
    @id userModel.id
    @email userModel.email
    @firstName userModel.first_name
    @lastName userModel.last_name
    @birthday moment(userModel.birthday) if userModel.birthday
