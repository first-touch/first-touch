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
        models = add_where(models, 'requests.id =', params[:id])
        models = add_where(models, 'requests.type_request =', params[:type_request])
        models = add_where(models, 'requests.status =', params[:status])
        if !params[:club].blank?
          # TODO: Refactor When club token is ready
          models = models.joins(:user)
          models = add_where(models, 'users.search_string iLIKE ', "%#{params[:club]}%")
        end
        models = models.where('request_bids.status IN (?)', params[:bids_status].split(','))  unless params[:bids_status].blank?
        models = models.having("count(request_bids.id) >= #{params[:min_bids]} ") unless params[:min_bids].blank?
        models = models.having("count(request_bids.id) <= #{params[:max_bids]} ") unless params[:max_bids].blank?

        models = filters_date(models, params)

        date = params[:created_date].to_date unless params[:created_date].blank?
        models = models.where created_at: date.all_day if date
        options['models'] = models
        true
      end

      def filters_date(models, params)
        unless params[:deadline_from].blank?
          date_from = params[:deadline_from].to_date
        end
        unless params[:deadline_to].blank?
          date_to = params[:deadline_to].to_date
        end
        date = params[:created_date].to_date unless params[:created_date].blank?
        models = models.where created_at: date.all_day if date
        if date_from
          models =
            if date_to
              models.where(deadline: date_from..date_to + 1.days)
            else
              models = models.where('deadline > ?', date_from)
            end
        elsif date_to
          models = models.where('deadline < ?', date_to + 1.days)
        end
        models
      end

      def add_where(models, column, value)
        models = models.where("#{column} ?", value) unless value.blank?
        models
      end

      def orders!(options, params:, **)
        models = options['models']
        if !params[:order].blank?
          order = params[:order_asc] == 'true' ? :asc : :desc
          if %w[id type_request status created_at deadline]
            .include?(params[:order])
            models = models.order({ params[:order] => order})
          elsif params[:order] == 'club'
            # TODO: Refactor When club token is ready
            models = models.joins(:user)
            models = models.order("users.search_string #{order}", )
          elsif params[:order] == 'bids'
            models = models.order("count(request_bids.id) #{order}", )
          elsif params[:order] == 'bid_price'
            models = models.order("request_bids.price->>'value' #{order}", )
          elsif params[:order] == 'bid_status'
            models = models.order("request_bids.status #{order}", )
          end
        end
        options['models'] = models
        true
      end
    end
  end
end
