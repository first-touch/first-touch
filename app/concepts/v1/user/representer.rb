module V1
  module User
    module Representer
      class SelfProfile < Representable::Decorator
        include Representable::JSON

        property :id
        property :career_history
        property :personal_profile,
                 extend: V1::PersonalProfile::Representer::Simplified

        property :has_stripe, getter: lambda { |represented:, **|
          begin
            !represented.stripe_ft.nil?
          rescue StandardError => e
            false
          end
        }

        property :has_bank_account, getter: lambda { |represented:, **|
          begin
            !represented.stripe_ft.preferred_account.nil?
          rescue StandardError => e
            false
          end
        }

        property :role_name, exec_context: :decorator
        property :current_club, exec_context: :decorator

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
