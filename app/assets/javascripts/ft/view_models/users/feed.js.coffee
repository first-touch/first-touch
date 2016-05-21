FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.Feed extends FT.ViewModels.Base
  constructor: (options) ->
    super options
    @userModel = new FT.DataModels.User
      user:
        id: FT.App._currentUserId()

    @postContents = ko.observable()
    @shareButtonDisabled = ko.pureComputed =>
      _.isEmpty @postContents()

    @feed = ko.observableArray()

    @triggerLoad()

  _load: ->
    userModelPromise = @userModel.find()
    # TODO: Fetch user feed based on timestamp
    Promise.all [userModelPromise]

  share: ->
    if @shareButtonDisabled()
      console.log "#{@postContents()}"
    else
      succcess = (postData) =>
        @postContents ''
        @feed.push new Post(postData)

      err = (jqXHR, textStatus, error) ->
        console.log error

      postModel = new FT.DataModels.Post()
      postModel.create {
        post:
          content: @postContents()
          user_id: @userModel.id
        },
        succcess,
        err

class Post
  constructor: (options) ->
    @author = options.user_id
    @content = options.content
    @updatedAt = moment(options.updated_at).format FT.Dictionaries.TimeFormats.DateTime
