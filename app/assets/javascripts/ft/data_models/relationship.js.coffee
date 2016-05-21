class FT.DataModels.Relationship extends FT.DataModels.Base
  API_ENDPOINT: 'api/v1/relationships'
  MODEL_NAME: 'relationship'
  USER_FOLLOWS_ENDPOINT: 'api/v1/users'
  ATTR_ACCESSIBLE: [
    'id'
    'follower_id'
    'followed_id'
  ]

  currentUserFollows: ->
    @id?

  follow: (userId) ->
    success = (data, textStatus, jqXHR) =>
      @_buildDataModel data

    err = (jqXHR, textStatus, error) ->
      console.log error

    @create(followed_id: userId, success, err)

  unfollow: ->
    success = (data, textStatus, jqXHR) =>
      @_buildDataModel data

    err = (jqXHR, textStatus, error) ->
      console.log error

    @destroy(id: @id, success, err)

  find: (params = {}, query = undefined) ->
    success = (data, textStatus, jqXHR) =>
      @_buildDataModel data

    err = (jqXHR, textStatus, error) ->
      console.log error

    @_request
      type: 'GET'
      url: @_buildFollowsUrl 'follows', query
      data: params
    , success
    , err

  _buildDataModel: (data) ->
    attr = data[@MODEL_NAME]
    @_resetKeys() unless attr?
    super data

  _resetKeys: ->
    _.each @ATTR_ACCESSIBLE, (attr) =>
      @[attr] = undefined


  _buildFollowsUrl: (action = 'follows', query = undefined) ->
    url = "/#{@USER_FOLLOWS_ENDPOINT}"
    url += "/#{@follower_id}"
    url += "/#{action}" if action
    url += "?#{$.param query}" if query
    url
