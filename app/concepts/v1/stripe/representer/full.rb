module V1
  module Stripe
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :business_type, as: :type

        nested :profile do
          property :individual,
          getter: ->(represented:, **){ represented.respond_to?(:individual) ? represented[:individual] : nil }
          property :company,
            getter: ->(represented:, **){ represented.respond_to?(:company) ? represented[:company] : nil }
        end

        property :country
        property :default_currency
        property :preferred_account, getter: lambda { |represented:, **|
          begin
            represented.preferred_id
          rescue StandardError
            'N/A'
          end
        }
        property :external_accounts, getter: lambda { |represented:, **|
          if represented.external_accounts.data
            obj = []
            begin
              represented.external_accounts.data.each do |bank|
                obj.push(::V1::Stripe::Representer::ResumeBank.new(bank))
              end
              obj
            rescue StandardError
              'N/A'
            end
          end
        }
      end

      class ResumeBank < Representable::Decorator
        include Representable::JSON

        property :account_holder_name
        property :bank_name
        property :country
        property :last4
        property :id
        property :default_for_currency
        property :currency
      end
    end
  end
end
