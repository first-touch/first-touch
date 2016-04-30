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
    matchingRoute = @_findRoute routeKey
    unless matchingRoute
      console.log 'no matching route'
      return

    if @[matchingRoute.routingMethod]
      @[matchingRoute.routingMethod](matchingRoute.params)
      @lastHash = routeKey
    else
      console.log 'routing method not implemented'

  routingTable:
    '/' : 'root'
    'profile/edit': 'editUserProfile'
    'profile': 'userProfile'
    'users/:id': 'viewPublicProfile'

  root: ->
    console.log 'users feed'

  userProfile: ->
    viewModel = new FT.ViewModels.Users.Profile()
    view = new FT.Views.Users.Profile
      viewModel: viewModel

    @appLayout.renderMain { main: view }

  editUserProfile: ->
    viewModel = new FT.ViewModels.Users.ProfileForm()
    view = new FT.Views.Users.ProfileForm
      viewModel: viewModel

    @appLayout.renderMain { main: view }

  viewPublicProfile: (params) ->
    if params.id == FT.App._currentUserId()
      @userProfile params
      return

    viewModel = new FT.ViewModels.Users.PublicProfile params
    view = new FT.Views.Users.PublicProfile
      viewModel: viewModel

    @appLayout.renderMain { main: view }

  _initializeListener: =>
    window.addEventListener 'hashchange', @_route, false

  _route: () =>
    @navigateTo @_routeFromLocation()

  _routeFromLocation: ->
    window.location.hash.slice(1) || '/'

  # FIXME: Routing table order is important. having profile/edit after profile fs up the routing
  _findRoute: (currentHash) ->
    matching = undefined
    _.each @routingTable, (routingMethod, routePath) =>
      variableNames = []
      regexRoute = routePath.replace(/([:*])(\w+)/g, ( (full, dots, name) =>
        variableNames.push(name)
        '([^\/]+)'
        )
      )+ '(?:\/|$)'
      matchingRoute = currentHash.match(new RegExp(regexRoute))
      matching = { routingMethod: routingMethod, params: @_buildParams(variableNames, matchingRoute.slice(1, matchingRoute.length)) } if matchingRoute
      !matching

    return matching

  _buildParams: (variableNames, paramsValues) ->
    if variableNames.length != paramsValues.length
      console.log 'Mismatching params and values'
    else
      variableNames.reduce( (params, key, index) ->
        params[key] = paramsValues[index]
        params
      , {}
      )
