module V1
  module Stripe
    class Delete < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true
      step :delete!
      failure :stripe_failure!, fail_fast: true
      private

      def find!(options,  params:, current_user:, **)
        options['model.class'] = ::Stripe::Account
        id = params[:id]
        if !current_user.stripe_id.nil?
          account = ::Stripe::Account.retrieve(current_user.stripe_id)
          if !account.nil?
            begin
              account.external_accounts.retrieve(id)
              options['model'] = account
            rescue => e
              options['stripe.errors'] = e.to_s
            end
          end
        end
        !options['model'].nil?
      end

      def delete!(options,  params:, current_user:, **)
        id = params[:id]
        type = params[:type]
        account = options['model']
        if type == 'bank_account'
          bank_account = account.external_accounts.retrieve(id)
          if !bank_account.nil?
            begin
              bank_account.delete()
            rescue => e
              body = e.json_body
              err = body[:error]
              options['stripe.errors'] = [I18n.t(err[:type])]
              # Something else happened, completely unrelated to Stripe
            end
          end
        end
        options['stripe.errors'].nil?
      end

    end
  end
end
