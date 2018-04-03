module V1
  module Report
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON

        property :id
        property :user, getter:  -> (represented:, **) {
          ::V1::PersonalProfile::Representer::Simplified.new(represented.user.personal_profile)
         }
        property :headline
        property :price
        property :type_report
        property :status

        property :player, getter:  -> (represented:, **) {
          if represented.player
          ::V1::PersonalProfile::Representer::Simplified.new(represented.player.personal_profile)
          end
         }
        property :created_at
        property :updated_at, getter:  -> (represented:, **) {
          if represented.report_data.last
            report_data.last.updated_at
          end
         }
        property :orders_status
        property :report_data, getter:  -> (represented:, **) {
          ::V1::ReportDatum::Representer::Resume.new(represented.report_data.last)
         }
      end
    end
  end
end
