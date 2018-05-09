module V1
  module Stripe
    class Update < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true
      step :update!
      private

      def find!(options,  params:, current_user:, **)
        options['model.class'] = ::Stripe::Account
        id = params[:id]
        type = params[:type]
        if !current_user.stripe_id.nil?
          account = ::Stripe::Account.retrieve(current_user.stripe_id)
          if !account.nil?
            if type == 'bank_account'
              begin
                account.external_accounts.retrieve(id)
                options['model'] = account
              rescue => e
                options['stripe.errors'] = e.to_s
              end
            end
          end
        end
        !options['model'].nil?
      end

      def update!(options,  params:, current_user:, **)
        id = params[:id]
        type = params[:type]
        account = options['model']
        if type == 'bank_account'
          bank_account = account.external_accounts.retrieve(id)
          if !bank_account.nil?
            bank_account.default_for_currency = true
            bank_account.save
            return true
          end
        end
        false
      end

    end
  end
end
