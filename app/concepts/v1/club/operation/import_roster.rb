module V1
  module Club
    class ImportRoster < FirstTouch::ClubOperation
      step :enqueue_import

      def enqueue_import(_options, params:, current_club:, **)
        ::Importer::Roster.perform_async(params['roster_url'], current_club.id)
      end
    end
  end
end
