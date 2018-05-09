module V1
  module Stripe
    class Create < FirstTouch::Operation
      step :setup_model!
      step :create!
      failure :stripe_failure!, fail_fast: true
      step :persist_stripe_id!

      private

      def setup_model!(options,  params:, current_user:, **)
        options['model'] = {}
      end

      def create!(options,  params:, current_user:, **)
        token = params['token']
        country = params['country']
        type = params['type']
        if !token.nil?
          if type == 'account'
            create_update_stripe_account(options, current_user, token, country)
          elsif type == 'bank_account'
            create_update_bank_account(options, current_user, token, country)
          end
        else
          options['stripe.errors'] = 'token_not_found'
        end
        options['stripe_id'] or options['update']
      end

      def create_update_bank_account(options,  current_user, token, country)
        if !current_user.stripe_id.nil?
          begin
            account = ::Stripe::Account.retrieve(current_user.stripe_id)
            options['model'] = account
            account.external_account = token
            account.save
            options['update'] = true
          rescue => e
            options['stripe.errors'] = e.to_s
          end
        else
          options['stripe.errors'] = 'no_stripe_account'
        end
      end

      def create_update_stripe_account(options,  current_user, token, country)
        if current_user.stripe_id.nil? and country
          begin
            account = ::Stripe::Account.create({
            :country => country,
            :type => "custom",
            :account_token => token
            })
          options['stripe_id'] = account.id
          options['model'] = account
          rescue => e
            options['stripe.errors'] = e.to_s
          end
        else
          begin
            account = ::Stripe::Account.retrieve(current_user.stripe_id)
            account.account_token = token
            account.save
            options['model'] = account
            options['update'] = true
          rescue => e
            options['stripe.errors'] = e.to_s
          end
        end
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
