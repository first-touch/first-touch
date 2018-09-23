module V1
  module User
    module Representer
      class PasswordUpdated < Representable::Decorator
        include Representable::JSON

        property :message, exec_context: :decorator

        def message
          I18n.t('user.updated_password')
        end
      end
    end
  end
end
