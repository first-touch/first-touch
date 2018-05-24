module V1
  module Report
    class Index < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :join_orders!
      step :filters!
      step :orders!

      private

      def find_model!(options, params:, current_user:, **)
        if current_user.is_a?(::User) && current_user.scout?
          options['models'] = current_user.reports.where.not(status: %w[pending deleted])
        elsif current_user.is_a?(::Club) || true
          # TODO: remove or true once club are ready
          options['models'] = club(params, current_user: current_user)

        end
        options['models'].blank?
        options['model.class'] = ::Report
      end

      def club(_params, current_user:)
        models = ::Report.all
        joins = "LEFT JOIN orders ON orders.customer_id = #{current_user.id}"\
        ' AND orders.report_id = reports.id'
        models = models.joins(joins)
        models = models.select('reports.*, orders.status AS orders_status, orders.completed_date AS orders_completed_date, orders.refund_status AS orders_refund_status')
      end

      def join_orders!(options, params:, current_user:, **)
        if current_user.is_a?(::User) && current_user.scout?
          true
        elsif current_user.is_a?(::Club) || true
          # TODO: remove or true once club are ready
          if params[:purchased] == 'true'
            purchased!(options, current_user)
          elsif !params[:request_id].blank?
            proposed!(options, current_user, params)
          else
            order_status!(options, current_user)
          end
        end
      end

      def proposed!(options, current_user, params)
        models = options['models']
        request = current_user.requests.find(params[:request_id]) if params[:request_id]
        unless request.nil?
          models = models.where('reports.request_id = ?', request.id)
        end
        options['models'] = models
      end

      def order_status!(options, current_user)
        models = options['models']

        joins = "LEFT JOIN orders ON orders.customer_id = #{current_user.id}"\
        ' AND orders.report_id = reports.id'
        models = models.where('reports.status = ? OR orders.status = ?', 'publish', 'completed')
        models = models.joins(joins)
        models = models.select('reports.*, orders.status AS orders_status')
        # models = models.group('reports.id', 'orders.status')
        options['models'] = models
      end

      def purchased!(options, current_user)
        models = options['models']
        models = models.where('orders.status' => %w[completed pending_report],
                              'orders.customer_id' => current_user.id.to_s)
        models = models.select(
          'reports.*, orders.status AS orders_status,'\
          ' orders.price AS orders_price'
        )
        options['models'] = models
      end

      def filters!(options, params:, **)
        models = options['models'].joins(:user)
        models = add_where(models, 'reports.id = ', params[:id])
        models = add_where(models, 'reports.type_report = ', params[:type_report])
        models = add_where(models, 'reports.completion_status = ', params[:completion_status])
        models = add_where(models, 'reports.headline iLIKE ', "%#{params[:headline]}%") unless params[:headline].blank?
        models = add_where(models, 'users.search_string iLIKE ', "%#{params[:scout_name]}%")
        models = filters_date(models, params)
        models = filters_price(models, params)
        options['models'] = models
      end

      def add_where(models, column, value)
        models = models.where("#{column} ?", value) unless value.blank?
        models
      end

      def filters_price(models, _params)
        models = models.where("(reports.price->>'value')::int >= ?", _params[:min_price]) unless _params[:min_price].blank?
        models = models.where("(reports.price->>'value')::int <= ?", _params[:max_price]) unless _params[:max_price].blank?
        models
      end

      def filters_date(models, params)
        unless params[:created_date_from].blank?
          date_from = params[:created_date_from].to_date
        end
        unless params[:created_date_to].blank?
          date_to = params[:created_date_to].to_date
        end
        date = params[:created_date].to_date unless params[:created_date].blank?
        models = models.where created_at: date.all_day if date
        if date_from
          models =
            if date_to
              models.where(created_at: date_from..date_to + 1.days)
            else
              models.where(created_at: date_from..DateTime.now)
            end
        elsif date_to
          models = models.where('reports.created_at < ?', date_to)
        end
        models
      end

      def orders!(options, params:, **)
        models = options['models']
        unless params[:order].blank?
          order = params[:order_asc] == 'true' ? :asc : :desc
          if %w[id created_at updated_at headline report_type completion_status]
             .include?(params[:order])
            models = models.order(params[:order] => order)
          elsif params[:order] == 'scout_name'
            models = models.includes(:user)
            models = models.order("users.search_string #{order}")
          elsif params[:order] == 'price'
            models = models.order("reports.price->>'value' #{order}")
          end
        end
        options['models'] = models
        true
      end
    end
  end
end
