module V1
  module Report
    module Representer
      class Show < Representable::Decorator
        include Representable::JSON

        property :id
        property :user_id
        property :headline
        property :meta_data
        property :price
        property :type_report

      end
    end
  end
end
