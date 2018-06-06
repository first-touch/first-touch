module V1
  module ClubStripe
    class Create < FirstTouch::Operation
      step :before_create!
      failure :stripe_failure!, fail_fast: true
      step :create!
      failure :stripe_failure!, fail_fast: true
      step :persist_stripe_id!

      private

      def before_create!(options, params:, **)
        token = params['token']
        result = false
        if !token.nil?
          result = true
        else
          options['stripe.errors'] = I18n.t 'token_not_found'
        end
        result
      end

      def create!(options, params:, current_club:, **)
        customer = nil
        success = true
        begin
          if current_club.stripe_id.nil?
            customer = ::Stripe::Customer.create(
              source: params['token']
            )
            options['stripe_id'] = customer.id
          else
            stripe_id = current_club.stripe_id
            customer = ::Stripe::Customer.retrieve(stripe_id)
            customer.sources.create(source: params['token'])
          end
          customer = ::Stripe::Customer.retrieve(customer.id)
        rescue StandardError => e
          success = false
          options['stripe.errors'] = e
        end
        options['model'] = customer
        success
      end

      def persist_stripe_id!(options, params:, current_club:, **)
        unless options['stripe_id'].nil?
          current_club.stripe_id = options['stripe_id']
          current_club.save!
          success = true
        end
        true
      end
    end
  end
end
