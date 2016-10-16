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
    '/'            : 'root'
    'profile/edit' : 'editUserProfile'
    'profile'      : 'userProfile'
    'users/:id'    : 'viewPublicProfile'
    'network'      : 'network'
    'messages'     : 'messages'

  root: ->
    @_render 'Users.Feed'

  network: ->
    @_render 'Users.Network'

  userProfile: ->
    @_render 'Users.Profile'

  editUserProfile: ->
    @_render 'Users.ProfileForm'

  viewPublicProfile: (params) ->
    if params.id == FT.App._currentUserId()
      @userProfile params
      return

    @_render 'Users.PublicProfile', { viewModelParams: params }

  messages: (params) ->
    @_render 'Users.Inbox', secondary: { className: 'InboxContainer', identifier: 'inboxcontainer' }

  _render: (className, options={}) ->
    classNamespaceParts = className.split '.'
    viewModel = FT.ViewModels
    view = FT.Views

    _.each classNamespaceParts, (part) ->
      viewModel = viewModel[part]
      view = view[part]

    viewModel = new viewModel options.viewModelParams
    view = new view
      viewModel: viewModel

    defaultOptions = { main: view }

    @appLayout.renderMain(_.extend defaultOptions, options)

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
