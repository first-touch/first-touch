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
        property :user, getter:  -> (represented:, **) {
          ::V1::PersonalProfile::Representer::Simplified.new(represented.user.personal_profile)
        }
        property :player, getter:  -> (represented:, **) {
          if represented.player
            ::V1::PersonalProfile::Representer::Simplified.new(represented.player.personal_profile)
          end
        }
        property :orders_status, getter:  -> (represented:, **) {
          begin
            represented.orders_status
          rescue
          end
         }
         property :orders_price, getter:  -> (represented:, **) {
          begin
            represented.orders_price
          rescue
          end
         }
        property :meta_data, getter:  -> (represented:, **) {
          ::V1::ReportMetaData::Representer::Resume.new(represented.meta_data)
        }
      end
    end
  end
end
