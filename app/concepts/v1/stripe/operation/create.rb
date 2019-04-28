module V1
  module Stripe
    class Create < FirstTouch::Operation
      step :setup_model!
      step :create!
      failure :stripe_failure!, fail_fast: true
      step :persist_stripe_id!
      step :set_preferred_acount!

      private

      def setup_model!(options, params:,  **)
        options[:model] = {}
      end

      def create!(options, params:,  **)
        token = params['token']
        country = params['country']
        type = params['type']
        if !token.nil?
          if type == 'account'
            create_update_stripe_account(options, token, country)
          elsif type == 'bank_account'
            create_update_bank_account(options, token, country)
          end
        else
          options['stripe.errors'] = 'token_not_found'
        end
        options['stripe_id'] || options['update']
      end

      def create_update_bank_account(options, token, _country)
        if !options[:current_user].stripe_ft.nil?
          stripe_ft = options[:current_user].stripe_ft
          begin
            account = ::Stripe::Account.retrieve(stripe_ft.stripe_id)
            options[:model] = account
            account.external_account = token
            account.save
            if account.external_accounts.data.length == 1
              stripe_ft.preferred_account = account.external_accounts.data[0].id
              stripe_ft.save!
            end
            options['update'] = true
          rescue StandardError => e
            options['stripe.errors'] = e
          end
        else
          options['stripe.errors'] = 'no_stripe_account'
        end
      end

      def create_update_stripe_account(options, token, country)
        if options[:current_user].stripe_ft.nil? && country
          begin
            account = ::Stripe::Account.create(
              country: country,
              type: 'custom',
              account_token: token
            )
            #account.transfer_schedule.interval = 'manual'
            account.save
            options['stripe_id'] = account.id
            options[:model] = account
          rescue StandardError => e
            options['stripe.errors'] = e
          end
        else
          begin
            account = ::Stripe::Account.retrieve(options[:current_user].stripe_ft.stripe_id)
            account.account_token = token
            account.save
            options[:model] = account
            options['update'] = true
          rescue StandardError => e
            options['stripe.errors'] = e
          end
        end
      end

      def persist_stripe_id!(options, params:,  **)
        success = false
        if !options['stripe_id'].nil?
          stripe_ft = ::StripeFt.new(
            stripe_id: options['stripe_id'],
            user: options[:current_user]
          )
          options[:current_user].stripe_ft = stripe_ft
          options[:current_user].save!
          success = true
        elsif options['update']
          success = true
        end
        success
      end

      def set_preferred_acount!(options, params:,  **)
        account = options[:model]
        stripe_ft = options[:current_user].stripe_ft
        pf = stripe_ft.preferred_account
        found = false
        if (not account.external_accounts.nil?)
          account.external_accounts.data.each do |item|
            found = true if pf == item.id
          end
        end

        unless found
          unless account.external_accounts.data.empty?
            stripe_ft.preferred_account = account.external_accounts.data[0].id
            stripe_ft.save!
          end
          options[:model] = account
        end
        account['preferred_id'] = stripe_ft.preferred_account
        true
      end
    end
  end
end
