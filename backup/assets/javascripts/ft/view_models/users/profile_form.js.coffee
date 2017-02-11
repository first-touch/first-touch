FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.ProfileForm extends FT.ViewModels.Users.Profile
  # FIXME: Get this to match pattern of datamodels
  constructor: ->
    super()

  updateProfile: ->
    updatedUserProfile = @userModel.update @_buildAPIModel()

    updatedUserProfile.then () ->
      FT.App.triggerFlashMessage 'Profile updated', 'success'

  _buildAPIModel: ->
    user:
      personal_profile_attributes:
        first_name:               @firstName()
        middle_name:              @middleName()
        last_name:                @lastName()
        birthday:                 @birthday()
        nationality_country_code: @nationality()
        residence_country_code:   @residency()
        summary:                  @summary()
        achievements:             @achievements()
        languages:                @languages()
