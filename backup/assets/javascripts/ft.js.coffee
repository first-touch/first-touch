#= require_self
#= require ./ft/views/base
#= require_tree ./ft/templates
#= require ./ft/views/layout/view_manager
#= require_tree ./ft/views
#= require ./ft/view_models/base
#= require ./ft/view_models/secondary_navigation_base
#= require ./ft/data_models/base
#= require_tree ./ft/data_models
#= require_tree ./ft/view_models
#= require_tree ./ft/routers
#= require_tree ./ft/lib

_.extend FT.App,
  start: ->
    @_initializeRouter() unless FT.router?
    if !@isUserSignedIn()
      @logout()
    else
      @_currentUserInitialized = @_initializeCurrentUser()

  isUserSignedIn: ->
    Cookies.get('ft_user_email')? && Cookies.get('ft_user_id')?

  _currentUserId: ->
    Cookies.get('ft_user_id')

  logout: ->
    # TODO: Move to apiClient
    $.ajax
      url: 'users/sign_out'
      type: 'DELETE'
    .done ->
      window.location.href = '/'

  _initializeRouter: ->
    FT.router = new FT.Routers.MainRouter()

  _initializeCurrentUser: ->
    @currentUserModel = new FT.DataModels.User(
      user:
        id: FT.App._currentUserId()
    )
    @currentUserModel.find()
