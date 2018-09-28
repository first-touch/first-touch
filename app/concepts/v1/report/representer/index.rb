module V1
  module Report
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :report, decorator: Resume

        property :count, getter: lambda { |represented:, **|
          count =
            {
              complete: 0,
              pending: 0
            }
          represented&.each do |r|
            count[:complete] = count[:complete] + 1 if r.completion_status == 'complete'
            count[:pending] = count[:pending] + 1 if r.completion_status == 'pending'
          end
          count
        }
      end
    end
  end
end
