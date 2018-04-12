module V1
  module ReportMetaData
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON

        property :player_info, getter:  -> (represented:, **) {
          if represented['player_info']
            represented['player_info']
          end
        }

      end
    end
  end
end
