module V1
  module ReportMetaData
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON

        property :player_info, getter:  lambda { |represented:, **|
          represented['player_info'] if represented['player_info']
        }
        property :formation, getter:  lambda { |represented:, **|
          represented['formation'] if represented['formation']
        }
        property :main_threats, getter:  lambda { |represented:, **|
          represented['main_threats'] if represented['main_threats']
        }

      end
    end
  end
end
