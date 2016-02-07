FT.Views.Users ||= {}

class FT.Views.Users.Profile extends FT.Views.Base
  template: templateFor 'ft/templates/users/profile'

  constructor: (options) ->
    super options
