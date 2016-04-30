FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.Profile extends FT.ViewModels.Base
  constructor: (options) ->
    super options
    @userModel = new FT.DataModels.Users.User()

    @userId = ko.observable()
    @firstName = ko.observable()
    @middleName = ko.observable()
    @lastName = ko.observable()
    @birthday = ko.observable()
    @nationality = ko.observable()
    @residency = ko.observable()
    @summary = ko.observable()
    @achievements = ko.observable()
    @languages = ko.observable()
    @profileCompleteness = ko.observable()

    @displayName = ko.computed =>
      _.compact([@firstName(), @middleName(), @lastName()]).join ' '

    @displayBirthday = ko.pureComputed =>
      @birthday()?.format(FT.Dictionaries.TimeFormats.Date) || ''

    @age = ko.pureComputed =>
      moment().diff(@birthday(), 'years')

    @initialize options
    @triggerLoad()

  initialize: (options) ->
    @userId FT.App._currentUserId()

  _load: ->
    FT.App.ApiClient.get("api/v1/users/#{@userId()}", @_loadUserProfile)

  _loadUserProfile: (userModel) =>
    @userModel._buildDataModel userModel
    @profileCompleteness @userModel.profileCompleteness

    personalData = @userModel.personalData
    if personalData
      @firstName  personalData.firstName
      @middleName personalData.middleName
      @lastName @userModel.personalData.lastName
      @birthday moment(@userModel.personalData.birthday, FT.Dictionaries.TimeFormats.Date)
      @nationality @userModel.personalData.nationalityCountryCode
      @residency @userModel.personalData.residenceCountryCode
      @summary @userModel.personalData.summary
      @achievements @userModel.personalData.achievements
      @languages @userModel.personalData.languages
