module V1
  module ReportDatum
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON
        property :meta_data
        property :created_at
        property :updated_at

        property :attachments, getter:  -> (represented:, **) {
          ::V1::Attachment::Representer::Index.new(represented.attachments)
         }
      end
    end
  end
end
