FT.ViewModels.Users ||= {}

class FT.ViewModels.Users.Network extends FT.ViewModels.Base
  constructor: (options) ->
    super options
    @following = ko.observableArray()
    @followers = ko.observableArray()
    @network = new FT.DataModels.Network()

    @triggerLoad()

  _load: ->
    @network.find().then =>
      @_loadNetworkData()

  _loadNetworkData: ->
    @followers _.map @network.followers, (follower) -> new Relationship follower
    @following _.map @network.following, (following) -> new Relationship following

class Relationship
  constructor: (options) ->
    @id = ko.observable options.id
    @email = ko.observable options.email
    @name = ko.observable options.name
    @role = ko.observable options.role || 'N/A'
    @currentClub = ko.observable options.current_club || 'Unemployed'
