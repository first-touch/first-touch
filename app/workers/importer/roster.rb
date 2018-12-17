require 'rubyXL'

module Importer
  class Roster
    include Sidekiq::Worker

    def perform(roster_file = nil, club_id = nil)
      return if club_id.nil?
      headers = %w[first_name last_name email
                   phone_number birthday nationality]

      workbook = RubyXL::Parser.parse(roster_file)
      worksheet = workbook.worksheets[0]
      worksheet.each_with_index do |row, idx|
        next if idx.zero?
        break if empty_row?(row)
        user_params = prepare_user(row, headers)
        ::V1::User::Import.(params: user_params, club_id: club_id)
      end
    end

    def prepare_user(row, headers)
      user = {}
      headers.each_with_index do |h, idx|
        user[h] = row.cells[idx]&.value
      end
      user
    end

    def empty_row?(row)
      row.cells[0..2].all?(&:nil?)
    end
  end
end
