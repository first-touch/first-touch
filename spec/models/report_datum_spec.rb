require 'rails_helper'

RSpec.describe ReportDatum, type: :model do

  describe "association" do
    it { is_expected.to belong_to  :report }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :meta_data }
    it { is_expected.to validate_presence_of :report }
  end

end
