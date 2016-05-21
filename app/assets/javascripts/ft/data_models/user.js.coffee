FT.DataModels ||= {}

class FT.DataModels.User extends FT.DataModels.Base
  API_ENDPOINT: 'api/v1/users'
  MODEL_NAME: 'user'

  constructor: (userAttrs) ->
    super userAttrs

  buildJSON: ->
    user:
      personal_profile_attributes:
        first_name: @personalData.firstName
        middle_name: @personalData.middleName
        last_name: @personalData.lastName
        birthday: @personalData.birthday
        achievements: @personalData.achievents
        languages: @personalData.languages
        nationality_country_code: @personalData.nationality
        residence_country_code: @personalData.residency
        summary: @personalData.summary

  _buildDataModel: (data) ->
    super data
    @_computeProfileCompleteness()

  # FIXME: Find a correct and nice way to calculate the profile completeness.
  # Currently is not computing it properly because of nested attributes
  _computeProfileCompleteness: ->
    59
