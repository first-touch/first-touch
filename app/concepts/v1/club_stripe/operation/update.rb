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
          account = ::Stripe::Customer.retrieve(current_user.stripe_ft.stripe_id)
          if !account.nil?
            begin
              account.sources.retrieve(id)
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
        account = options['model']
        account.default_source = id
        options['model'] = account
      end

    end
  end
end
