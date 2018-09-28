module V1
  module ClubStripe
    class Delete < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true
      step :delete!
      failure :stripe_failure!, fail_fast: true

      private

      def find!(options, params:, current_club:, **)
        options['model.class'] = ::Stripe::Customer
        id = params[:id]
        if !id.nil? && !current_club.stripe_id.nil?
          account = ::Stripe::Customer.retrieve(current_club.stripe_id)
          unless account.nil?
            begin
              account.sources.retrieve(id)
              options['model'] = account
            rescue StandardError => e
              options['stripe.errors'] = e
            end
          end
        end
        !options['model'].nil?
      end

      def delete!(options, params:, current_club:, **)
        id = params[:id]
        account = options['model']
        card = account.sources.retrieve(id)
        unless card.nil?
          begin
            card.delete
          rescue StandardError => e
            options['stripe.errors'] = e
          end
        end
        options['model'] = ::Stripe::Customer.retrieve(account.id)
        options['stripe.errors'].nil?
      end
    end
  end
end
