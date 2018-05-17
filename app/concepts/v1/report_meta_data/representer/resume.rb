module V1
  module ReportMetaData
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON

        property :player_info, getter:  lambda { |represented:, **|
          represented['player_info'] if represented['player_info']
        }
      end
    end
  end
end
