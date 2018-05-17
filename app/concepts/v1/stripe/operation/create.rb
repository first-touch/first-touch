module V1
  module Stripe
    class Create < FirstTouch::Operation
      step :setup_model!
      step :create!
      failure :stripe_failure!, fail_fast: true
      step :persist_stripe_id!
      step :set_preferred_acount!
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
        if !current_user.stripe_ft.nil?
          stripe_ft = current_user.stripe_ft
          begin
            account = ::Stripe::Account.retrieve(stripe_ft.stripe_id)
            options['model'] = account
            account.external_account = token
            account.save
            if account.external_accounts.data.length == 1
              stripe_ft.preferred_account = account.external_accounts.data[0].id
              stripe_ft.save!
            end
            options['update'] = true
          rescue => e
            options['stripe.errors'] = e
          end
        else
          options['stripe.errors'] = 'no_stripe_account'
        end
      end

      def create_update_stripe_account(options,  current_user, token, country)
        if current_user.stripe_ft.nil? and country
          begin
            account = ::Stripe::Account.create({
            :country => country,
            :type => "custom",
            :account_token => token
            })
            account.transfer_schedule.interval = 'manual'
            account.save
          options['stripe_id'] = account.id
          options['model'] = account
          rescue => e
            options['stripe.errors'] = e
          end
        else
          begin
            account = ::Stripe::Account.retrieve(current_user.stripe_ft.stripe_id)
            account.account_token = token
            account.save
            options['model'] = account
            options['update'] = true
          rescue => e
            options['stripe.errors'] = e
          end
        end
      end

      def persist_stripe_id!(options,  params:, current_user:, **)
        success = false
        if !options['stripe_id'].nil?
          stripe_ft = ::StripeFt.new(
            stripe_id: options['stripe_id'],
            user: current_user
            )
          current_user.stripe_ft = stripe_ft
          current_user.save!
          success = true
        elsif options['update']
          success = true
        end
        success
      end

      def set_preferred_acount!(options,  params:, current_user:, **)
        account = options['model']
        stripe_ft = current_user.stripe_ft
        pf = stripe_ft.preferred_account
        found = false
        account.external_accounts.data.each do |item|
          if pf == item.id
            found = true
          end
        end
        if !found
          if account.external_accounts.data.length > 0
            stripe_ft.preferred_account = account.external_accounts.data[0].id
            stripe_ft.save!
          end
          options['model'] = account
        end
        account['preferred_id'] = stripe_ft.preferred_account
        true
      end

    end
  end
end
