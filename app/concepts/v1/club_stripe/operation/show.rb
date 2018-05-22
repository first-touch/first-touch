module V1
  module ClubStripe
    class Show < FirstTouch::Operation
      step :find_account!
      failure :model_not_found!, fail_fast: true
      private

      def find_account!(options,  params:, current_user:, **)
        options['model.class'] = ::Stripe::Account
        model = nil
        if !current_user.stripe_ft.nil?
          account = ::Stripe::Customer.retrieve(current_user.stripe_ft.stripe_id)
          #TODO: Refactor once club_token is ready
          if !account.nil?
            account['preferred_id'] = current_user.stripe_ft.preferred_account
            options['model'] = model = account
          end
        end
        # options['result.model'] = result = Result.new(!model.nil?, {})
        # !options['model'].nil?
        true
      end

    end
  end
end
