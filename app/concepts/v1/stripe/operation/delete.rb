module V1
  module Stripe
    class Delete < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true
      step :delete!
      step :update_preferred_account!
      step :bid_accepted!
      step :balance_empty!
      step :delete_stripe_account!
      failure :stripe_failure!, fail_fast: true
      step :unpublish_all!

      private

      def find!(options, params:,  **)
        options['model.class'] = ::Stripe::Account
        id = params[:id]
        unless options[:current_user].stripe_ft.nil?
          account = ::Stripe::Account.retrieve(options[:current_user].stripe_ft.stripe_id)
          unless account.nil?
            if params[:type] == 'bank_account'
              begin
                account.external_accounts.retrieve(id)
                options[:model] = account
              rescue StandardError => e
                options['stripe.errors'] = e
              end
            else
              options[:model] = account
            end
          end
        end
        !options[:model].nil?
      end

      def delete!(options, params:,  **)
        id = params[:id]
        type = params[:type]
        account = options[:model]
        if type == 'bank_account'
          bank_account = account.external_accounts.retrieve(id)
          unless bank_account.nil?
            begin
              bank_account.delete
            rescue StandardError => e
              options['stripe.errors'] = e
            end
          end
          options[:model] = ::Stripe::Account.retrieve(account.id)
        end
        options['stripe.errors'].nil?
      end

      def bid_accepted!(options, params:,  **)
        type = params[:type]
        success = true
        if type == 'whole_account'
          success = options[:current_user].request_bids.where(status: 'accepted').blank?
          unless success
            options['stripe.errors'] = I18n.t 'stripe.delete_bid_accepted'
          end
        end
        success
      end

      def balance_empty!(options, params:,  **)
        type = params[:type]
        account = options[:model]
        if type == 'whole_account'
          balance = ::Stripe::Balance.retrieve(stripe_account: account.id)
          balance_empty = true
          unless balance.nil?
            balance.available.each do |b|
              balance_empty = false if b[:amount] != 0
            end
            balance.pending.each do |b|
              balance_empty = false if b[:amount] != 0
            end
          end
          unless balance_empty
            options['stripe.errors'] = I18n.t 'stripe.balance_not_empty'
          end
        end
        options['stripe.errors'].nil?
      end

      def delete_stripe_account!(options, params:,  **)
        account = options[:model]
        type = params[:type]
        if type == 'whole_account'
          begin
            account.delete
            options[:current_user].stripe_ft.delete
            options[:model] = nil
          rescue StandardError => e
            options['stripe.errors'] = e
          end
        end
        options['stripe.errors'].nil?
      end

      def unpublish_all!(options, params:,  **)
        if options[:model].nil?
          options[:current_user].reports.where(status: 'publish').update_all status: 'private'
          options[:current_user].request_bids.where(status: 'pending').delete_all
        end
        true
      end

      def update_preferred_account!(options, params:,  **)
        id = params[:id]
        account = options[:model]
        stripe_ft = options[:current_user].stripe_ft
        if id == stripe_ft.preferred_account
          stripe_ft.preferred_account = unless account.external_accounts.data.empty?
                                          account.external_accounts.data[0].id
                                        end
          stripe_ft.save!
        end
        true
      end
    end
  end
end
