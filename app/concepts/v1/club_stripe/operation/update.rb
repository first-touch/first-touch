module V1
  module ClubStripe
    class Update < FirstTouch::Operation
      step :find!
      failure :model_not_found!, fail_fast: true
      step :update!

      private

      def find!(options, params:, current_club:, **)
        options['model.class'] = ::Stripe::Account
        id = params[:id]
        type = params[:type]
        unless current_club.stripe_id.nil?
          account = ::Stripe::Customer.retrieve(current_club.stripe_id)
          unless account.nil?
            begin
              account.sources.retrieve(id)
              options[:model] = account
            rescue StandardError => e
              options['stripe.errors'] = e.to_s
            end
          end
        end
        !options[:model].nil?
      end

      def update!(options, params:, current_club:, **)
        id = params[:id]
        account = options[:model]
        account.default_source = id
        account.save
        options[:model] = account
      end
    end
  end
end
