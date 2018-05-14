module V1
  module ClubStripe
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
        success = false
        if type == 'preferred'
          account.external_accounts.retrieve(id)
          stripe_ft = current_user.stripe_ft
          stripe_ft.preferred_account = id
          stripe_ft.save!
          success = true
        end
        if success
          account['preferred_id'] = current_user.stripe_ft.preferred_account
          options['model'] = account
        end
        success
      end

    end
  end
end
