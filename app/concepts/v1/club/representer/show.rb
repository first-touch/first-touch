module V1
  module Club
    module Representer
      class Show < Representable::Decorator
        include Representable::JSON
        # TODO: Consider extending the full representer that already
        # includes this first block
        property :id
        property :name
        property :city
        property :country_code
        property :owner?, as: :has_owner, exec_context: :decorator
        property :club_logo, exec_context: :decorator

        # TODO: This should move to a representer only available for
        # authenticated users
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
        def owner?
          !represented.account_owner_id.nil?
        end

        def club_logo
          # TODO: Update this to get the club logo from DB
          # if represented.avatar.attached?
          #   rails_blob_path(represented.avatar)
          # else
          FirstTouch::CLUB_LOGO
          # end
        end
      end
    end
  end
end
