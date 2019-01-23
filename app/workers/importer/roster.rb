module Importer
  class Roster
    include Sidekiq::Worker

    def perform(roster_file = nil, club_id = nil)
      import_params = { roster_file: roster_file, club_id: club_id }
      res = ::V1::Roster::Import.(params: import_params)
      return if res.success?
      # TODO: Track roster import errors
    end
  end
end
