module V1
  module ReportDatum
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON
        property :meta_data, getter:  -> (represented:, **) do
          if represented
            if represented.report.type_report == 'player'
              represented.meta_data['userinfo']
            end
          end
        end
      end
    end
  end
end
