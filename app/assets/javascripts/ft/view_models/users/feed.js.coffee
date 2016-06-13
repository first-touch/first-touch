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
    # TODO: Find a way of integrating this with
    # DataModels
    feedPromise =(->
      ajaxCall = $.ajax
        type: 'GET'
        dataType: 'json'
        url: 'api/v1/posts'

      ajaxCall.done (response) ->
        Promise.resolve response

      ajaxCall.fail (xhr) ->
        console.log xhr
        errorMessage = (err(xhr) if err) || "Failed to make changes on the server"
        Promise.reject errorMessage
    )()

    feedPromise.then (postsData) =>
      @feed _.map postsData.posts, (post) ->
        new Post post

    Promise.all [userModelPromise, feedPromise]

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
      newPostPromise = postModel.create {
        post:
          content: @postContents()
          user_id: @userModel.id
        }

      newPostPromise.then (postModel) =>
        @postContents ''
        @feed.push new Post(postModel)


class Post
  constructor: (options) ->
    @postModel = new FT.DataModels.Post options
    @author = options.user_id
    @content = options.content
    @updatedAt = moment(options.updated_at).format FT.Dictionaries.TimeFormats.DateTime
