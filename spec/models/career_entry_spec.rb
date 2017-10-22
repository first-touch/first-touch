require 'rails_helper'

RSpec.describe CareerEntry, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :start_date }

    it 'checks if start date is before end date' do
      invalid_entry = build :career_entry,
                            start_date: Date.today,
                            end_date: Date.yesterday
      expect(invalid_entry).to be_invalid
      errors = invalid_entry.errors.full_messages
      expect(errors).to eq ['Start date has to be earlier than end date']

      valid_entry = build :career_entry,
                          start_date: Date.yesterday,
                          end_date: Date.today
      expect(valid_entry).to be_valid
    end

    it 'accepts nil for end date' do
      valid_entry = build :career_entry,
                          start_date: Date.yesterday,
                          end_date: nil
      expect(valid_entry).to be_valid
    end
  end
end
