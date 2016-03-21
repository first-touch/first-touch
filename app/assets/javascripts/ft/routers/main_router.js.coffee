class FT.Routers.MainRouter
  constructor: (options) ->
    @appLayout = new FT.Views.Layout.AppLayout()
    @_initializeListener()
    @lastHash = ''
    if window.location.hash == '' && !(/\/#/.test(window.location.href))
      window.location = '/#'
    else
      @navigateTo @_routeFromLocation()

  navigateTo: (routeKey) ->
    route = @routes[routeKey]
    if route? && @[route]
      @[route]()
      @lastHash = routeKey
    else
      console.log 'route not found'

  routes:
    '/' : 'root'
    'profile': 'userProfile'
    'profile/edit': 'editUserProfile'

  root: ->
    console.log 'users feed'

  userProfile: ->
    console.log 'user Profile'
    viewModel = new FT.ViewModels.Users.Profile()
    view = new FT.Views.Users.Profile
      viewModel: viewModel

    @appLayout.renderMain { main: view }

  editUserProfile: ->
    console.log 'user Profile Editing'
    viewModel = new FT.ViewModels.Users.ProfileForm()
    view = new FT.Views.Users.ProfileForm
      viewModel: viewModel

    @appLayout.renderMain { main: view }

  _initializeListener: =>
    window.addEventListener 'hashchange', @_route, false

  _route: () =>
    @navigateTo @_routeFromLocation()

  _routeFromLocation: ->
    window.location.hash.slice(1) || '/'
