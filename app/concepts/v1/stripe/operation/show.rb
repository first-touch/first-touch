module V1
  module Stripe
    class Show < FirstTouch::Operation
      step :find_account!
      failure :model_not_found!, fail_fast: true
      private

      def find_account!(options,  params:, current_user:, **)
        options['model.class'] = ::Stripe::Account
        if !current_user.stripe_ft.nil?
          account = ::Stripe::Account.retrieve(current_user.stripe_ft.stripe_id)
          if !account.nil?
            account['preferred_id'] = current_user.stripe_ft.preferred_account
            options['model'] = account
          end
        end
        !options['model'].nil?
      end

    end
  end
end
