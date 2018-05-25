module V1
  module ClubStripe
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :default_source
        property :cards, getter: lambda { |represented:, **|
          if represented.sources.data
            obj = []
            begin
              represented.sources.data.each do |card|
                obj.push(::V1::ClubStripe::Representer::ResumeBank.new(card))
              end
              obj
            rescue StandardError
              'N/A'
            end
          end
        }
      end

      class ResumeBank < Representable::Decorator
        include Representable::JSON

        property :exp_month
        property :exp_year
        property :last4
        property :id
        property :brand
      end
    end
  end
end
