module V1
  module Report
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :user, getter:  -> (represented:, **) {
          ::V1::PersonalProfile::Representer::Simplified.new(represented.user.personal_profile)
         }
        property :headline
        property :report_data, getter:  -> (represented:, **) {
          ::V1::ReportDatum::Representer::Full.new(represented.report_data.last)
         }
         property :player, getter:  -> (represented:, **) {
           if represented.player
            ::V1::PersonalProfile::Representer::Simplified.new(represented.player.personal_profile)
           end
         }
        property :price
        property :type_report
        property :status

      end
    end
  end
end
