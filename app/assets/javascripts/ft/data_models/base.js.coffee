class FT.DataModels.Base
  constructor: (attr) ->
    @_buildDataModel attr if attr

  find: (params = {}, query = undefined) ->
    success = (data, textStatus, jqXHR) =>
      @_buildDataModel data

    err = (jqXHR, textStatus, error) ->
      console.log error

    @_request
      type: 'GET'
      url: @_buildUrl undefined, query
      data: params
    , success
    , err

  create: (data, success, err, action = undefined, query = undefined) ->
    @_request
      type: 'POST'
      url: @_buildUrl action, query
      data: data
    , success
    , err

  update: (data, success, err, action = undefined, query = undefined) ->
    @_request
      type: 'PUT'
      url: @_buildUrl action, query
      data: data
    , success
    , err

  destroy: (data, success, err, action = undefined, query = undefined) ->
    @_request
      type: 'DELETE'
      url: @_buildUrl action, query
      data: data
    , success
    , err

  # FIXME: Not used
  asJSON: ->
    obj = {}
    @attributes.forEach key =>
      obj[key] = @[key] if @[key]?

    obj

  _buildDataModel: (attr) ->
    attr = attr[@MODEL_NAME]

    for key, value of attr
      @[key] = value

  _buildUrl: (action = undefined, query = undefined) =>
    url = "/#{@API_ENDPOINT}"
    url += "/#{@id}" if @id
    url += "/#{action}" if action
    url += "?#{$.param query}" if query
    url

  _request: (options, success, err) ->
    return new Promise (resolve, reject) =>
      ajaxCall = $.ajax
        type: options.type
        dataType: 'json'
        url: options.url
        data: options.data

      ajaxCall.done (response) =>
        if success
          success(response)
        else
          console.log "[DataModel : Ajax Succes]", response
        resolve @

      ajaxCall.fail (xhr) ->
        #FT.App.defaultAjaxFailure(xhr)
        console.log xhr
        errorMessage = (err(xhr) if err) || "Failed to make changes on the server"
        reject errorMessage
