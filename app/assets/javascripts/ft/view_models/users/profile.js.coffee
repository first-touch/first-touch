FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.Profile extends FT.ViewModels.Base
  constructor: (options) ->
    super options
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
    @userModel = new FT.DataModels.User(
      user:
        id: FT.App._currentUserId()
    )

  _load: ->
    @userModel.find().then =>
      @_loadUserProfile()

  _loadUserProfile: =>
    @profileCompleteness @userModel.profileCompleteness

    personalData = @userModel.personal_profile
    if personalData
      @firstName  personalData.first_name
      @middleName personalData.middle_name
      @lastName personalData.last_name
      @birthday moment(personalData.birthday, FT.Dictionaries.TimeFormats.Date)
      @nationality personalData.nationality_country_code
      @residency personalData.residence_country_code
      @summary personalData.summary
      @achievements personalData.achievements
      @languages personalData.languages
