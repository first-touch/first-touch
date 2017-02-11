FT.ViewModels ||= {}

class FT.ViewModels.Base
  constructor: ->
    @loaded = ko.observable false
    @subscriptions = []
    @loadHooks = []
    @afterLoadHooks = []
    @beforeLoadHooks = []

    @loadPromises = ko.observable()
    @afterLoadPromises = ko.observable()
    @beforeLoadPromises = ko.observable()

  _subscribe: (observable, subscription) =>
    @subscriptions.push observable.subscribe subscription

  triggerLoad: ->
    @beforeLoadPromises(@_beforeLoad())
    @loadPromises(@beforeLoadPromises().then( => @_load()))
    @afterLoadPromises(@loadPromises().then( => @_afterLoad()))

  _load: ->
    Promise.all []

  _afterLoad: ->
    @loaded true
    Promise.all []

  _beforeLoad: ->
    @loaded false
    Promise.all []

  beforeDestroy: ->
    window.onbeforeunload = null
