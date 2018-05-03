module V1
  module Stripe
    class Create < FirstTouch::Operation
      step :setup_model!
      step :create!
      failure :process_payment_failure!, fail_fast: true
      step :persist_stripe_id!

      private

      def setup_model!(options,  params:, current_user:, **)
        options['model'] = {}
      end

      def create!(options,  params:, current_user:, **)
        token = params['token']
        if !token.nil?
          if current_user.stripe_id.nil?
            customer = ::Stripe::Account.create({
              :country => "SG",
              :type => "custom",
              :account_token => token
              })
            options['stripe_id'] = customer.id
          else
            account = ::Stripe::Account.retrieve(current_user.stripe_id)
            account.account_token = token
            account.save
            options['update'] = true
          end
        else
          options['stripe.errors'] = 'Errorrrs '
        end
        options['stripe_id'] or options['update']
      end

      def persist_stripe_id!(options,  params:, current_user:, **)
        if !options['stripe_id'].nil?
          current_user.stripe_id = options['stripe_id']
          current_user.save!
          true
        elsif options['update']
          true
        else
          false
        end
      end

    end
  end
end
