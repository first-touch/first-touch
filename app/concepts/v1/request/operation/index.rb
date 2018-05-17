module V1
  module Request
    class Index < FirstTouch::Operation
      step :find_model!
      step :filters!
      step :orders!

      private

      def find_model!(options, current_user:, **)
        if current_user.is_a?(::User) && current_user.scout?
          models = scout(current_user: current_user)
          # models = ::Request.all.where status: 'publish'
        elsif current_user.is_a?(::Club) || true
          # Todo: or true need to be remove when club are ready
          models = club(current_user: current_user)
        end
        options['models'] = models
        options['model.class'] = ::Request
      end

      def scout(current_user:)
        models = ::Request.all
        joins = "LEFT OUTER JOIN request_bids ON request_bids.request_id = requests.id AND request_bids.user_id = #{current_user.id} AND request_bids.status != 'canceled' "
        models = models.joins(joins)
        models = models.where('request_bids.status IN (\'pending\', \'accepted\') OR requests.status = ?','publish')
        models = models.select('requests.*, request_bids.status as bid_status, request_bids.price as bid_price, request_bids.report_id as report_id')
      end

      def club(current_user:)
        models = current_user.requests.where.not(status: 'deleted')
        joins = "LEFT OUTER JOIN request_bids ON request_bids.request_id = requests.id AND request_bids.status = 'pending'"
        models = models.joins(joins)
        models = models.select('requests.*, COUNT(request_bids.id) as request_bids_count')
        models = models.group('requests.id')
      end

      def filters!(options, params:, **)
        models = options['models']
        models = add_where(models, 'requests.id', params[:id])
        models = add_where(models, 'requests.type_request', params[:type_request])
        models = add_where(models, 'requests.status', params[:status])
        models = add_where(models, 'request_bids.status', params[:bids_status].split(',')) if params[:bids_status]
        models = models.having("count(request_bids.id) >= #{params[:min_bids]} ") unless params[:min_bids].blank?

        date = params[:created_date].to_date unless params[:created_date].blank?
        models = models.where created_at: date.all_day if date
        options['models'] = models
        true
      end

      def add_where(models, column, value)
        obj = {column.to_sym => value}
        models = models.where(obj) unless value.blank?
        models
      end

      def orders!(options, params:, **)
        models = options['models']
        if !params[:order].blank?
          order = params[:order_asc] == 'true' ? :asc : :desc
          if %w[id type_request status created_at]
            .include?(params[:order])
            models = models.order({ params[:order] => order})
          elsif params[:order] == 'bids'
            models = models.order("count(request_bids.id) #{order}", )
          end
        end
        options['models'] = models
        true
      end
    end
  end
end
