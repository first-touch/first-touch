FT.Views.Users ||= {}

class FT.Views.Users.PublicProfile extends FT.Views.Base
  template: templateFor 'ft/templates/users/public_profile'

  constructor: (options) ->
    super options
