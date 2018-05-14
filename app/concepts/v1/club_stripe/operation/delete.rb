module V1
  module ClubStripe
    class Delete < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true
      step :delete!
      failure :stripe_failure!, fail_fast: true
      step :update_preferred_account!
      private

      def find!(options,  params:, current_user:, **)
        options['model.class'] = ::Stripe::Account
        id = params[:id]
        if !current_user.stripe_ft.nil?
          account = ::Stripe::Account.retrieve(current_user.stripe_ft.stripe_id)
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
              options['stripe.errors'] = err[:message]
            end
          end
          options['model'] = ::Stripe::Account.retrieve(account.id)
        end
        options['stripe.errors'].nil?
      end

      def update_preferred_account!(options,  params:, current_user:, **)
        id = params[:id]
        account = options['model']
        stripe_ft = current_user.stripe_ft
        if id == stripe_ft.preferred_account
          if account.external_accounts.data.length > 0
            stripe_ft.preferred_account = account.external_accounts.data[0].id
          else
            stripe_ft.preferred_account = nil
          end
          stripe_ft.save!
        end
        true
      end

    end
  end
end
