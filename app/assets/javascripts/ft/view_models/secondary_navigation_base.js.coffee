FT.ViewModels ||= {}

class FT.ViewModels.SecondaryNavigationBase extends FT.ViewModels.Base
  constructor: (options) ->
    super options
    @mainViewModel = options.mainViewModel
