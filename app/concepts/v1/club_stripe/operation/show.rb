module V1
  module ClubStripe
    class Show < FirstTouch::Operation
      step :find_account!
      failure :model_not_found!, fail_fast: true

      private

      def find_account!(options, params:, current_club:, **)
        options['model.class'] = ::Stripe::Account
        model = nil
        unless current_club.stripe_id.nil?
          account = ::Stripe::Customer.retrieve(current_club.stripe_id)
          options['model'] = model = account unless account.nil?
        end
        options['result.model'] = result = Result.new(!model.nil?, {})
        true
      end
    end
  end
end
