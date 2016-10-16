FT.ViewModels ||= {}

class FT.ViewModels.InboxContainer extends FT.ViewModels.SecondaryNavigationBase
  constructor: (options) ->
    super options

    @searchFriendName = ko.observable()
    @inbox = new FT.DataModels.Inbox()
    @messagesFeed = ko.observableArray()

    @triggerLoad()

  _load: ->
    @inbox.find().then =>
      @_loadMessagesData()

  _loadMessagesData: ->
    console.log 'load data'

class MessageThread
  constructor: (options) ->
    @recipient = ko.observable options.id
    @allMessages = ko.observableArray options.messages

    @allMessagesRead = ko.pureComputed ->
      _.any @allMessages, (message) ->
        !message.read
