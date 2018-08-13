require 'reform/form/validation/unique_validator'

module V1
  module CareerEntry
    module Contract
      class Create < Reform::Form
        property :club
        property :start_date
        property :end_date
        property :user
        property :role

        validates :club, :user, :start_date, :role, presence: true
      end
    end
  end
end
