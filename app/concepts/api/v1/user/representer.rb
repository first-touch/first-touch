module Api
  module V1
    module User
      module Representer
        class Base < Representable::Decorator
          include Representable::JSON
          property :id
          property :personal_profile, extend: Api::V1::PersonalProfile::Representer::Show
          property :career_history, exec_context: :decorator

          def career_history
            represented.career_history
          end
        end
      end
    end
  end
end
