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
        if !current_user.stripe_ft.stripe_id.nil?
          account = ::Stripe::Account.retrieve(current_user.stripe_ft.stripe_id)
          if !account.nil?
            begin
              account.external_accounts.retrieve(id)
              account['preferred_id'] = current_user.stripe_ft.preferred_account
              options['model'] = account
            rescue => e
              options['stripe.errors'] = e.to_s
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
        if type == 'preferred'
          account.external_accounts.retrieve(id)
          stripe_ft = current_user.stripe_ft
          stripe_ft.preferred_account = id
          stripe_ft.save!
          puts stripe_ft.to_json
          return true
        end
        false
      end

    end
  end
end
