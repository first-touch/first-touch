module Importer
  class Roster
    include Sidekiq::Worker

    def perform(roster_url = nil, club_id = nil)
      import_params = { roster_url: roster_url, club_id: club_id }
      res = ::V1::Roster::Import.(params: import_params)
      return if res.success?
      # TODO: Track roster import errors
    end
  end
end
