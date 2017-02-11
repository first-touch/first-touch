FT.Views.Users ||= {}

class FT.Views.Users.ProfileForm extends FT.Views.Base
  template: templateFor 'ft/templates/users/form'

  constructor: (options) ->
    super options
