FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.PublicProfile extends FT.ViewModels.Users.Profile
  constructor: (options) ->
    super options

    @currentFollowStatus = ko.observable false
    @followUnfollowText = ko.pureComputed =>
      if @currentFollowStatus()
        'Unfollow'
      else
        'Follow'

  initialize: (options) ->
    @userModel = new FT.DataModels.User(
      user:
        id: options.id
    )
    @relationship = new FT.DataModels.Relationship
      relationship:
        follower_id: FT.App._currentUserId()

  # TODO: Can be shared with the profile view model and split into public contents
  # and private contents
  _loadUserProfile: =>
    super()
    @relationship.find( { followed_id: @userModel.id } ).then =>
      @_updateRelationshipStatus()

  followUnfollow: ->
    if @currentFollowStatus()
      @relationship.unfollow().then =>
        @_updateRelationshipStatus()
    else
      @relationship.follow(@userModel.id).then =>
        @_updateRelationshipStatus()

  _updateRelationshipStatus: ->
    if @relationship.currentUserFollows()
      @currentFollowStatus true
    else
      @currentFollowStatus false
