module V1
  module Report
    class Index < FirstTouch::Operation
      step :find_model!
      step :filters!
      private

      def find_model!(options, params:, current_user:, **)
        if is_scout? current_user
          options['models'] = current_user.reports
          return true
        elsif is_club? current_user
          options['models'] = ::Report.all.where status: 'publish'
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
        # models = models.joins(:orders).where("orders.user_id = 1")
        joins = "LEFT JOIN orders ON orders.customer_id = #{current_user.id.to_s} AND orders.report_id = reports.id"
        models = models.joins(joins).select('reports.*, orders.status AS orders_status').group('reports.id','orders.status')
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
