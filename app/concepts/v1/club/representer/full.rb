module V1
  module Club
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON
        property :id
        property :name
        property :city
        property :country_code
        property :owner?, exec_context: :decorator
        property :club_logo, exec_context: :decorator

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
