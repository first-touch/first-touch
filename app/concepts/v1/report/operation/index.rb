module V1
  module Report
    class Index < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :join_orders!
      step :filters!
      step :orders!

      private

      def find_model!(options, current_user:, **)
        # if current_user.is_a?(::User) && current_user.scout?
        #   options['models'] = current_user.reports
        if current_user.is_a?(::Club) || true
          # Todo: remove or true once club are ready
          options['models'] = ::Report.all.where status: 'publish'
        end
        options['models'].blank?
        options['model.class'] = ::Report
      end

      def join_orders!(options, params:, current_user:, **)
        if current_user.is_a?(::Club) || true
          # Todo: remove or true once club are ready
          models = if params[:purchased] == 'true'
                     purchased!(options['models'], current_user)
                   else
                     order_status!(options['models'], current_user)
            end
          options['models'] = models
        end
      end

      def order_status!(models, current_user)
        joins = "LEFT JOIN orders ON orders.customer_id = #{current_user.id}"\
        ' AND orders.report_id = reports.id'
        models = models.joins(joins)
        models = models.select('reports.*, orders.status AS orders_status')
        models = models.group('reports.id', 'orders.status')
        models
      end

      def purchased!(models, current_user)
        models = models.joins(orders: :user)
        models = models.where('orders.status' => 'completed',
                              'orders.customer_id' => current_user.id.to_s)
        models = models.select(
          'reports.*, orders.status AS orders_status,'\
          ' orders.price AS orders_price'
        )
        models
      end

      def filters!(options, params:, **)
        models = options['models'].joins(:user)
        models = add_where(models, 'reports.id = ', params[:id])
        models = add_where(models, 'reports.type_report = ', params[:type_report])
        models = add_where(models, 'reports.headline iLIKE ', "%#{params[:headline]}%")
        models = add_where(models, 'users.search_string iLIKE ', "%#{params[:user_name]}%")
        models = filters_date(models, params)
        models = filters_price(models, params)
        options['models'] = models
      end

      def add_where(models, column, value)
        models = models.where("#{column} ?", value) unless value.blank?
        models
      end

      def filters_price(models, _params)
        # Todo: to be review after switching price to json (to add the currency)
        # price_min = (params[:price_min].blank?) ? 0 : params[:price_min].to_i
        # price_max = (params[:price_max].blank?) ? 999999 : params[:price_max].to_i
        # models = models.where price: price_min..price_max
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
          models = models.where('created_at < ?', date_to)
        end
        models
      end

      def orders!(options, params:, **)
        models = options['models']
        if !params[:order].blank? &&
           %w[id price created_at updated_at headline report_type]
           .include?(params[:order])
          models = models.order params[:order].to_sym
        end
        options['models'] = models
        true
      end
    end
  end
end
