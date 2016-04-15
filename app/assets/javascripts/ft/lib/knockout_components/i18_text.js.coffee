ko.bindingHandlers.i18Text =
  init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
    # first called when the binding is first applied
    # setup initial states, event handlers, ...

    @key = valueAccessor().i18
    # TODO:
    # Listen to language changes

  update: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
    # called once when applied and then whenever observables change
    # update dom element based on the supplied values
    currentLanguage = window.navigator.language
    # TODO: consider fetching from server the dictionary on language change
    i18Text = FT.Dictionaries.i18[currentLanguage]?[@key] || FT.Dictionaries.i18['en-US']?[@key] || "Translation missing for #{@key} - #{currentLanguage}"

    children = $(element).children()
    $(element).text("#{i18Text} ")

    children.each (index, child) ->
      $(element).append child
