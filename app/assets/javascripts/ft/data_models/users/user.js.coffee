FT.DataModels.Users ||= {}

class FT.DataModels.Users.User extends FT.DataModels.Base
  API_ENDPOINT: 'api/v1/users'
  accessibleAttributes: [
    'id'
    'personal_profile': [
      'first_name',
      'middle_name',
      'last_name',
      'birthday',
      'nationality_country_code',
      'residence_country_code',
      'summary',
      'achievements',
      'languages'
    ]
  ]
  MODEL_NAME: 'user'

  constructor: (userAttrs) ->
    super userAttrs
    @_computeProfileCompleteness()

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
    if data
      userAttrs = data[@MODEL_NAME]
      @id = userAttrs.id
      @personalData = {}
      # FIXME: This should be accessed differently. Consider using an hash for the accessible attributes
      _.each @accessibleAttributes[1]['personal_profile'], (personalDataKey) =>
        key = _.camelCase personalDataKey
        @personalData[key] = userAttrs['personal_profile'][personalDataKey]

      @_computeProfileCompleteness()

  # FIXME: Find a correct and nice way to calculate the profile completeness.
  # Currently is not computing it properly because of nested attributes
  _computeProfileCompleteness: ->
    totalKeysCount = @_totalKeys @accessibleAttributes
    @profileCompleteness = _.ceil((_.keys(@).length / totalKeysCount) * 100)

  _totalKeys: (attrList) ->
    count = 0
    defined = 0
    _.each attrList, (attr) =>
      if typeof attr == 'object'
        count += @_totalKeys(attr)
      else
        count += 1
    count
