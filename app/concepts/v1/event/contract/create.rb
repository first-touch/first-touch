# require 'reform/form/validation/unique_validator'

module V1
  module Event
    module Contract
      class Create < Reform::Form
        property :evt_type
        property :opponent_id
        property :name
        property :venue
        property :start_date
        property :end_date
        property :description

        validates :evt_type, presence: true
      end
    end
  end
end
