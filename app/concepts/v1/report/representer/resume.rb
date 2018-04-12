module V1
  module Report
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON

        property :id
        property :headline
        property :price
        property :type_report
        property :status

        property :created_at
        property :updated_at
        property :user, getter: lambda { |represented:, **|
          ::V1::PersonalProfile::Representer::Simplified.new(
            represented.user.personal_profile
          )
        }
        property :player, getter: lambda { |represented:, **|
          if represented.player
            ::V1::PersonalProfile::Representer::Simplified.new(
              represented.player.personal_profile
            )
          end
        }
        property :orders_status, getter: lambda { |represented:, **|
          begin
            represented.orders_status
          rescue StandardError
            'N/A'
          end
        }
        property :orders_price, getter: lambda { |represented:, **|
          begin
            represented.orders_price
          rescue StandardError
            'N/A'
          end
        }
        property :meta_data, getter:  lambda { |represented:, **|
          ::V1::ReportMetaData::Representer::Resume.new(represented.meta_data)
        }
      end
    end
  end
end
