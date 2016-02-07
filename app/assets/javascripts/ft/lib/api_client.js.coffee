FT.App.ApiClient =
  get: (url, successCallback, errorCallback) ->
    Promise.resolve($.get(url: url)).then (data) ->
      successCallback data
    .catch (err) ->
      if errorCallback? && typeof errorCallback is 'function'
        errorCallback err
      else
        FT.App.ApiClient.defaultErrorHandler err

  put: ->
    console.log 'putURL'

  post: ->
    console.log 'postURL'

  delete: ->
    console.log 'deleteURL'

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
