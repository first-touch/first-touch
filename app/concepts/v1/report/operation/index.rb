module V1
  module Report
    class Index < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :filters!
      step :orders!

      private

      def find_model!(options, params:, current_user:, current_club:, **)
        models = nil
        if current_user.is_a?(::User) && current_user.scout?
          models = current_user.reports.not_hided
        elsif !current_club.nil? || true
          # TODO: remove or true once club are ready
          models= club(params, options, current_user: current_user)
        end
        options['result.model'] = result = Result.new(!options['models'].nil?, {})
        options['model.class'] = ::Report
        options['models'] = models
      end

      def club(_params, options, current_user:)
        if _params[:purchased] == 'true'
          purchased!(options, current_user)
        elsif !_params[:request_id].blank?
          proposed!(options, current_user, _params)
        else
          marketplace!(options, current_user)
        end
      end

      def proposed!(options, current_user, params)
        models = nil
        request = current_user.requests.find(params[:request_id]) if params[:request_id]
        unless request.nil?
          models = ::Report.proposed_reports request.id
        end
        options['models'] = models
      end

      def marketplace!(options, current_user)
        models = ::Report.purchased_by_user_or_publish current_user.id
        options['models'] = models
      end

      def purchased!(options, current_user)
        models = options['models']
        models = ::Report.purchased_by_user current_user.id
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
