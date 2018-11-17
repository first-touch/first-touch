module V1
  module Stripe
    class FieldNeeded < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true

      private

      def find!(options, params:,  **)
        country = params[:country]
        options[:model] = ::Stripe::CountrySpec.retrieve(country)
        !options[:model].nil?
      end
    end
  end
end
