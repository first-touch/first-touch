require 'roo'

module V1
  module Roster
    class Import < Trailblazer::Operation

    # HEADER_PARAM = {
    #   'First Name' => 'first_name',
    #   'Middle Name' => 'middle_name',
    #   'Last Name' => 'last_name',
    #   'Email' => 'email',
    #   'Birthday' => 'birthday',
    #   'Place of Birth' => 'place_of_birth',
    #   'Weight' => 'weight',
    #   'Height' => 'height',
    #   'Preferred Foot' => 'preferred_foot',
    #   'Preferred Playing Position' => 'playing_position',
    #   'Playing Position' => 'playing_position',
    #   'Professional Status' => 'pro_status'
    # }.freeze

      # TODO: Identify file type
      # Reject if not xlsx nor csv
      # If xlsx convert to csv
      # Parse csv

    #   workbook = RubyXL::Parser.parse(roster_file)
    #   worksheet = workbook.worksheets[0]
    #   worksheet.each_with_index do |row, idx|
    #     next if idx.zero?
    #     break if empty_row?(row)
    #     user_params = prepare_user(row)
    #     puts user_params
    #     # ::V1::User::Import.(params: user_params, club_id: club_id)
    #   end
    # end

    # def prepare_user(row)
    #   user = {}
    #   HEADER_PARAM.each do |header, param|
    #     puts header
    #     puts param
    #     debugger
    #     user[param] = row.cells[header]&.value
    #   end
    #   user
    # end

    # def empty_row?(row)
    #   row.cells[0..2].all?(&:nil?)
    # end

      step :determine_file_type
      step :build_csv

      def success
        puts "yay"
        true
      end
    end
  end
end
