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
    @userId options.id

  # TODO: Can be shared with the profile view model and split into public contents
  # and private contents
  _loadUserProfile: (userModel) =>
    super userModel
    # TODO: relationship should probably be another datamodel
    @_updateRelationshipStatus userModel.relationship

  followUnfollow: ->
    if @currentFollowStatus()
      FT.App.ApiClient.delete("api/v1/relationships/#{@relationship.id}", @_followUnfollowSuccess)
    else
      FT.App.ApiClient.post("api/v1/relationships", { followed_id: @userId }, @_followUnfollowSuccess)

  _followUnfollowSuccess: (data) =>
    @_updateRelationshipStatus data.relationship

  _updateRelationshipStatus: (relationship) ->
    @relationship = relationship
    if @relationship?
      @currentFollowStatus true
    else
      @currentFollowStatus false
