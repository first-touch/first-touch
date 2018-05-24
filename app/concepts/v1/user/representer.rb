module V1
  module User
    module Representer
      class SelfProfile < Representable::Decorator
        include Representable::JSON

        property :id
        property :personal_profile,
                 extend: V1::PersonalProfile::Representer::Simplified

        property :has_stripe, getter: lambda { |represented:, **|
          !represented.stripe_ft.nil?
        }

        property :has_bank_account, getter: lambda { |represented:, **|
          if represented.stripe_ft
            !represented.stripe_ft.preferred_account.nil?
          else
            false
          end
        }

        property :role_name, exec_context: :decorator

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
