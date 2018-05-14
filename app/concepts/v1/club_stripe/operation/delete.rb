module V1
  module ClubStripe
    class Delete < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true
      step :delete!
      failure :stripe_failure!, fail_fast: true
      private

      def find!(options,  params:, current_user:, **)
        options['model.class'] = ::Stripe::Customer
        id = params[:id]
        if !id.nil? and !current_user.stripe_ft.nil?
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

      def delete!(options,  params:, current_user:, **)
        id = params[:id]
        account = options['model']
        card = account.sources.retrieve(id)
        if !card.nil?
          begin
            card.delete()
          rescue => e
            body = e.json_body
            err = body[:error]
            options['stripe.errors'] = err[:message]
          end
        end
        options['model'] = ::Stripe::Customer.retrieve(account.id)
        options['stripe.errors'].nil?
      end

    end
  end
end
