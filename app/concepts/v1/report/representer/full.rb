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
        property :meta_data
         property :player, getter:  -> (represented:, **) {
           if represented.player
            ::V1::PersonalProfile::Representer::Simplified.new(represented.player.personal_profile)
           end
         }
        property :price
        property :type_report
        property :status

        property :attachments, getter:  -> (represented:, **) {
          if represented.attachments
           ::V1::Attachment::Representer::Index.new(represented.attachments)
          end
        }

      end
    end
  end
end
