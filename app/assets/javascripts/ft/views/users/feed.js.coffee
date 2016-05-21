FT.Views.Users ||= {}

class FT.Views.Users.Feed extends FT.Views.Base
  template: templateFor 'ft/templates/users/feed'

  constructor: (options) ->
    super options
