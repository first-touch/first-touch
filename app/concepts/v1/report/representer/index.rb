module V1
  module Report
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :report, decorator: Resume
      end
    end
  end
end