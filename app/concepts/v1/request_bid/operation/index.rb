module V1
  module RequestBid
    class Index < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :filters!
      step :orders!

      private

      def find_model!(options, params:, current_user:, current_club:, **)
        requestId = params[:request_id]
        models = nil
        if current_user.is_a?(::User) && current_user.scout?
          models = ::RequestBid.find_by(request_id: requestId, user: current_user)
        elsif !current_club.nil? || true
          # TODO: or true need to be remove when club are ready
          models = current_user.requests.find(requestId).request_bids.where status: 'pending'
        end
        options['models'] = models
        options['model.class'] = ::RequestBid
        models
      end

      def filters!(options, params:, **)
        models = options['models']
        models = models.where("(price->>'value')::int >= ?", params[:price_min]) unless params[:price_min].blank?
        models = models.where("(price->>'value')::int <= ?", params[:price_max]) unless params[:price_max].blank?
        date = params[:created_date].to_date unless params[:created_date].blank?
        models = models.where created_at: date.all_day if date
        options['models'] = models
        true
      end

      def orders!(options, params:, **)
        models = options['models']
        unless params[:order].blank?
          order = params[:order_asc] == 'true' ? :asc : :desc
          if %w[created_at]
             .include?(params[:order])
            models = models.order(params[:order] => order)
          elsif params[:order] == 'price'
            models = models.order("price->>'value' #{order}")
          elsif params[:order] == 'scout_name'
            models = models.includes(:user)
            models = models.order("users.search_string #{order}")
          end
        end
        options['models'] = models
        true
      end
    end
  end
end
