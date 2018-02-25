require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end


  describe 'Note ML Fields' do
    it 'should have a valid enumeration' do
      pending 'finalize field_types'
      fail
    end
    it 'should have a valid JSON structure' do
      pending 'finalize field_elements'
      fail
    end
  end

end
