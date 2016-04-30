FT.App.ApiClient =
  get: (url, successCallback, errorCallback) ->
    Promise.resolve($.get(url: url)).then (data) ->
      successCallback data
    .catch (err) ->
      if errorCallback? && typeof errorCallback is 'function'
        errorCallback err
      else
        FT.App.ApiClient.defaultErrorHandler err

  put: (url, data, successCallback, errorCallback) ->
    Promise.resolve(
      $.ajax(
        url: url
        data: data
        method: 'PUT'
      )
    ).then (data) ->
      successCallback data
    .catch (err) ->
      if errorCallback? && typeof errorCallback is 'function'
        errorCallback err
      else
        FT.App.ApiClient.defaultErrorHandler err

  post: (url, data, successCallback, errorCallback) ->
    Promise.resolve(
      $.ajax(
        url: url
        data: data
        method: 'POST'
      )
    ).then (data) ->
      successCallback data
    .catch (err) ->
      if errorCallback? && typeof errorCallback is 'function'
        errorCallback err
      else
        FT.App.ApiClient.defaultErrorHandler err

  delete: (url, successCallback, errorCallback) ->
    Promise.resolve(
      $.ajax(
        url: url
        type: 'DELETE'
      )
    ).then (data) ->
      successCallback data
    .catch (err) ->
      if errorCallback? && typeof errorCallback is 'function'
        errorCallback err
      else
        FT.App.ApiClient.defaultErrorHandler err


  update: ->
    console.log 'updateURL'

  defaultErrorHandler: (err) ->
    switch err.status
      when 404
        alert 'not implemented on server side'
      when 0
        alert 'connection to server lost'
      when 401
        alert 'You are not authorized'
      when 422
        alert 'Server does not have what you want'
