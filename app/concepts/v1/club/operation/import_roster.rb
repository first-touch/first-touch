module V1
  module Club
    class ImportRoster < FirstTouch::ClubOperation
      step :enqueue_import

      # TODO: Include other possible file types
      # ACCEPTED_FILETYPES = [
      #   'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      #   'text/csv'
      # ].freeze

      # # TODO: make this an app constant
      # FINAL_TEMP_PATH = "#{Rails.root}/tmp/uploads".freeze

      # step :save_file
      # failure :invalid_file, fail_fast: true
      # step :enqueue_import

      private

      # def save_file(options, params:, **)
      #   return false unless @ACCEPTED_FILETYPES.include params['roster'].content_type
      #   filename = params['roster'].original_filename
      #   options['roster_file'] = "#{@FINAL_TEMP_PATH}/#{filename}"
      #   FileUtils.mv params['roster'].tempfile, options['roster_file']
      # end

      def enqueue_import(_options, params:, current_club:, **)
        ::Importer::Roster.perform_async(params['roster_url'], current_club.id)
      end

      # def invalid_file(options, **)
      #   # TODO: Make this a translatable string
      #   options['errors'] = 'Unsupported roster file'
      # end
    end
  end
end
