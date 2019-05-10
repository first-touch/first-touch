module V1
  module RequestBid
    class Index < FirstTouch::Operation
      step :setup_models!
      step :apply_filters!
      # failure :model_not_found!, fail_fast: true
      # step :filters!
      # step :orders!

      private


      def setup_models!(options, current_user:, **)
        options[:models] = current_user.request_bids
        # requestId = params[:request_id]
        # models = nil
        # if options[:current_user].scout?
        #   models = ::RequestBid.find_by(request_id: requestId, user: options[:current_user])
        # #elsif !current_club.nil?
        # #  models = current_club.requests.find(requestId).request_bids.where status: 'pending'
        # elsif !current_user.nil?
        #   models = current_user.requests.find(requestId).request_bids.where status: 'pending'
        # end
        # options[:models] = models
        # options['model.class'] = ::RequestBid
        # models
      end

      def apply_filters!(options, params:, models:, **)
        options[:models] = models.where(request_id: params[:request_id]) if params[:request_id]
        true
      end

      def filters!(options, params:, **)
        models = options[:models].joins(:user)
        models = models.where("(price->>'value')::int >= ?", params[:price_min]) unless params[:price_min].blank?
        models = models.where("(price->>'value')::int <= ?", params[:price_max]) unless params[:price_max].blank?
        models = models.where('users.search_string iLIKE ?', "%#{params[:scout_name]}%")

        date = params[:created_date].to_date unless params[:created_date].blank?
        models = models.where created_at: date.all_day if date
        models = filters_date(models, params)
        options[:models] = models
        true
      end

      def filters_date(models, params)
        date_from = params[:created_date_from].blank? ? nil : params[:created_date_from].to_date
        date_to = params[:created_date_to].blank? ? nil : params[:created_date_to].to_date
        models = models.where('request_bids.created_at > ?', date_from) if date_from
        models = models.where('request_bids.created_at < ?', date_to) if date_to
        models
      end

      def orders!(options, params:, **)
        models = options[:models]
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
        options[:models] = models
        true
      end
    end
  end
end
