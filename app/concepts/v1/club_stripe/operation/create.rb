module V1
  module ClubStripe
    class Create < FirstTouch::Operation
      step :before_create!
      failure :process_payment_failure!, fail_fast: true
      step :create!
      step :persist_stripe_id!
      private

      def before_create!(options,  params:, current_user:, **)
        token = params['token']
        result = false
        if !token.nil?
          result = true
        else
          options['stripe.errors'] = 'token_not_found'
        end
        result
      end

      def create!(options, params:, current_user:, **)
        customer = nil
        begin
          if current_user.stripe_ft.nil?
            customer = Stripe::Customer.create({
              source: params['token'],
              email: current_user.email,
            })
            options['stripe_id'] = customer.id
          else
            stripe_ft = current_user.stripe_ft
            customer = Stripe::Customer.retrieve(stripe_ft.stripe_id)
            customer.sources.create(source: params['token'])
          end
          rescue => e
            customer = nil
            body = e.json_body
            err  = body[:error]
            options['stripe.errors'] = err[:message]
        end
        options['model'] = customer
      end


      def persist_stripe_id!(options,  params:, current_user:, **)
        if !options['stripe_id'].nil?
          stripe_ft = ::StripeFt.new(
            stripe_id: options['stripe_id'],
            user: current_user
          )
          current_user.stripe_ft = stripe_ft
          current_user.save!
          success = true
        end
        true
      end

    end
  end
end
