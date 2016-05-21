_.extend FT.App,

  triggerFlashMessage: (content, status) ->
    $elm = $('#bottom-feeback')
    $elm.removeClass()
    $elm.text content
    $elm.addClass status

    setTimeout (-> $elm.addClass('slide-up')), 100
