module V1
  module ReportDatum
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON
        property :meta_data, getter:  -> (represented:, **) do
          if represented
            if represented.report.type_report == 'player'
              represented.meta_data['userinfo']
            elsif represented.report.type_report == 'team'
              {
                formation: represented.meta_data['formation'],
                main_threats: represented.meta_data['main_threats']
              }
            end
          end
        end
        property :attachments, getter:  -> (represented:, **) {
          if represented
          ::V1::Attachment::Representer::Resumes.new(represented.attachments)
          end
         }
      end
    end
  end
end
