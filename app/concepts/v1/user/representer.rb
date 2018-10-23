module V1
  module User
    module Representer
      class SelfProfile < Representable::Decorator
        include Representable::JSON

        property :id
        property :career_history
        property :personal_profile,
                 extend: V1::PersonalProfile::Representer::Simplified

        property :stripe?, as: 'has_stripe', exec_context: :decorator
        property :bank_account?, as: 'has_bank_account', exec_context: :decorator

        property :role_name, exec_context: :decorator
        property :current_club, exec_context: :decorator

        def stripe?
          !represented.stripe_ft.nil?
        end

        def bank_account?
          !represented.stripe_ft&.preferred_account.nil?
        end

        def current_club
          return nil unless represented.clubs.length.positive?
          V1::Club::Representer::Show.new(represented.clubs.first)
        end

        def role_name
          represented.roles.first.name
        end
      end

      class PublicProfile < SelfProfile
        property :following
        property :connection_status
      end
    end
  end
end
