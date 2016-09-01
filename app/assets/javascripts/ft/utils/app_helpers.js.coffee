_.extend FT.App,
  triggerFlashMessage: (content, status) ->
    $elm = $('#bottom-feeback')
    $elm.removeClass()
    $elm.text content
    $elm.addClass status

    setTimeout (-> $elm.addClass('slide-up')), 100

  currentUrlClass: (expectedHash) ->
    expectedHash = "##{expectedHash}" if expectedHash[0] != '#' && expectedHash.length > 0

    return "current" if location.hash == expectedHash
    return ''
