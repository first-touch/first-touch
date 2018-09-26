require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "association" do
    it { is_expected.to belong_to  :user }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :headline }
    it { is_expected.to validate_presence_of :type_report }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0).is_less_than_or_equal_to(999999).only_integer }
  end
end
