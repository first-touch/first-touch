module V1
  module Report
    module Representer
      class Show < Representable::Decorator
        include Representable::JSON

        property :id
        property :user_id
        property :headline
        property :report_data, getter:  -> (represented:, **) { represented.report_data.last }
        property :price
        property :type_report

      end
    end
  end
end
