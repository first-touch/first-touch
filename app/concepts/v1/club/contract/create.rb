# # require 'reform/form/validation/unique_validator'

module V1
  module Club
    module Contract
      class Create < Reform::Form
        property :name
        property :city
        property :country_code
        property :stadium_name
        property :date_founded
        property :twitter_handle
        property :website
        property :history
        property :address
        property :phone_number
        property :email
        property :facebook_link
        property :home_kit_color
        property :away_kit_color
        property :third_kit_color
        property :account_owner

        validates :name, :country_code, :account_owner, presence: true
      end
    end
  end
end
