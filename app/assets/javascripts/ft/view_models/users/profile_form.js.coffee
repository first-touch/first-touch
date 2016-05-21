FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.ProfileForm extends FT.ViewModels.Users.Profile
  # FIXME: Get this to match pattern of datamodels
  constructor: ->
    super()

  updateProfile: ->
    @userModel.personalData.firstName = @firstName()
    @userModel.personalData.middleName = @middleName()
    @userModel.personalData.lastName = @lastName()
    @userModel.personalData.birthday = @birthday()
    @userModel.personalData.nationality = @nationality()
    @userModel.personalData.residency = @residency()
    @userModel.personalData.summary = @summary()
    @userModel.personalData.achievements = @achievements()
    @userModel.personalData.languages = @languages()

    FT.App.ApiClient.put("api/v1/users/#{FT.App._currentUserId()}", @_buildAPIModel())

  _buildAPIModel: ->
    @userModel.buildJSON()
