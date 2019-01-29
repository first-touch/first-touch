require 'roo'
require 'file_type_detector'
require 'securerandom'

module V1
  module Roster
    class Import < Trailblazer::Operation
      FINAL_TEMP_PATH = "#{Rails.root}/tmp/uploads".freeze
      EXCEL_FILE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'.freeze
      # TODO: Improve CSV detection
      CSV_FILE = 'text/plain'.freeze
      ACCEPTED_FILETYPES = [
        EXCEL_FILE,
        CSV_FILE
      ].freeze

      HEADER_PARAM = {
        'First Name' => 'first_name',
        'Middle Name' => 'middle_name',
        'Last Name' => 'last_name',
        'Email' => 'email',
        'Birthday' => 'birthday',
        'Place of Birth' => 'place_of_birth',
        'Weight' => 'weight',
        'Height' => 'height',
        'Preferred Foot' => 'preferred_foot',
        'Preferred Playing Position' => 'playing_positions',
        'Professional Status' => 'pro_status'
      }.freeze

      step :download_file
      step :determine_file_type
      failure :unsupported_file, fail_fast: true
      step :build_csv
      step :parse_file

      def download_file(options, params:, **)
        roster_file = open(params[:roster_url])
        filename = roster_file.base_uri.to_s.split('/')[-1]
        uuid = SecureRandom.hex(20)
        final_dir = "#{FINAL_TEMP_PATH}/#{uuid}"
        system 'mkdir', '-p', final_dir
        storing_path = "#{final_dir}/#{filename}"
        IO.copy_stream(roster_file, storing_path)
        options[:roster_file] = storing_path
      end

      def determine_file_type(options, **)
        file_type = FileTypeDetector.mime_type(options[:roster_file])
        return false unless ACCEPTED_FILETYPES.include? file_type
        options[:convert] = file_type == EXCEL_FILE
        true
      end

      def unsupported_file(options, **)
        options[:errors] = I18n.t('club.roster.import.unsupported_file')
      end

      def build_csv(options, **)
        if options[:convert]
          # TODO: Find a way to convert xlsx file into csv
          puts 'TODO'
        end
        file = options[:roster_file]
        options[:csv] = CSV.read(file, headers: true)
      end

      def parse_file(options, params:, **)
        options[:csv].each do |row|
          user_params = prepare_user(row)
          ::V1::User::Import.(params: user_params, club_id: params[:club_id])
        end
      end

      def prepare_user(row)
        user = {}
        HEADER_PARAM.each do |header, param|
          value = if header == 'Playing Position'
                    { 'position': row[header], 'skill': 5 }
                  else
                    row[header]
                  end
          user[param] = value
        end
        user
      end
    end
  end
end
