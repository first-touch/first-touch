module V1
  module Stripe
    class Show < FirstTouch::Operation
      step :find_account!
      failure :model_not_found!, fail_fast: true
      private

      def find_account!(options,  params:, current_user:, **)
        options['model.class'] = ::Stripe::Account
        if !current_user.stripe_id.nil?
          account = ::Stripe::Account.retrieve(current_user.stripe_id)
          puts account.to_json
          if !account.nil?
            options['model'] = account
          end
        end
        !options['model'].nil?
      end

    end
  end
end
