module V1
  module Report
    class Index < FirstTouch::Operation
      step :find_model!
      step :filters!
      step :orders!
      private

      def find_model!(options, params:, current_user:, **)
        if is_scout? current_user
          options['models'] = current_user.reports
          return true
        elsif is_club? current_user
          if params[:purchased] == 'true'
            models = ::Report.joins(:orders => :user).where("orders.status" => 'completed',"orders.customer_id" => current_user.id.to_s ).select("distinct reports.*, orders.status AS orders_status, orders.price AS orders_price")
          else
            models = ::Report.all.where status: 'publish'
            joins = "LEFT JOIN orders ON orders.customer_id = #{current_user.id.to_s} AND orders.report_id = reports.id"
            models = models.joins(joins).select('reports.*, orders.status AS orders_status').group('reports.id','orders.status')
          end
          models = models.joins(:user);
          options['models']  = models
          return true
        end
        false
      end

      def filters!(options, params:, current_user:, **)
        if !options['models'].blank?
          models = options['models']
          models = models.where id: params[:id] if !params[:id].blank?
          models = models.where type_report: params[:type_report] if !params[:type_report].blank?
          models = models.where('headline iLIKE ?', "%#{params[:headline]}%") if !params[:headline].blank?
          models = models.where('users.search_string iLIKE ?', "%#{params[:user_name]}%") if !params[:user_name].blank?

          price_min = (params[:price_min].blank?) ? 0 : params[:price_min].to_i
          price_max = (params[:price_max].blank?) ? 999999 : params[:price_max].to_i
          models = models.where price: price_min..price_max
          date_from = params[:created_date_from].to_date if !params[:created_date_from].blank?
          date_to = params[:created_date_to].to_date if !params[:created_date_to].blank?
          date = params[:created_date].to_date if !params[:created_date].blank?
          if date
            models = models.where :created_at => date.all_day
          end
          if date_from
            if date_to
              models = models.where :created_at => date_from..date_to
            else
              models = models.where :created_at => date_from..DateTime.now
            end
          else
            if date_to
              models = models.where("created_at < ?",date_to)
            end
          end
        end
        options['models'] = models
        true
      end

      def orders!(options, params:, current_user:, **)
        models = options['models']
        if params[:order] == 'id'
          models = models.order(:id)
        elsif params[:order] == 'type_report'
          models = models.order(:type_report)
        elsif params[:order] == 'headline'
          models = models.order(:headline)
        elsif params[:order] == 'status'
          models = models.order(:status)
        elsif params[:order] == 'created_on'
          models = models.order(:created_at)
        elsif params[:order] == 'price'
          models = models.order(:price)
        end

        options['models'] = models
        true
      end


      def is_club?(current_user)
        true
      end

      def is_scout?(current_user)
        current_user.roles.first.name == 'scout'
      end
    end
  end
end
