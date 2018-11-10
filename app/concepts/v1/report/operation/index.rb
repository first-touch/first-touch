module V1
  module Report
    class Index < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :filters!
      step :orders!

      private

      def find_model!(options, params:,  current_club:, **)
        models = nil
        if options[:current_user].is_a?(::User) && options[:current_user].scout?
          models = options[:current_user].reports.not_hided
        elsif !current_club.nil?
          models = club(options, params, current_club: current_club)
        end
        options['result.model'] = result = Result.new(!options['models'].nil?, {})
        options['model.class'] = ::Report
        options['models'] = models
      end

      def club(options, params:, current_club:)
        if _params[:purchased] == 'true'
          purchased!(options, current_club)
        elsif !_params[:request_id].blank?
          proposed!(options, current_club, _params)
        else
          marketplace!(options, current_club)
        end
      end

      def proposed!(options, current_club, params)
        models = nil
        request = current_club.requests.find(params[:request_id]) if params[:request_id]
        models = ::Report.proposed_reports request.id unless request.nil?
        options['models'] = models
      end

      def marketplace!(options, current_club)
        models = ::Report.purchased_by_club_or_publish current_club.id
        options['models'] = models
      end

      def purchased!(options, current_club)
        models = options['models']
        models = ::Report.purchased_by_club current_club.id
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
        date_from = params[:created_date_from].blank? ? nil : params[:created_date_from].to_date
        date_to = params[:created_date_to].blank? ? nil : params[:created_date_to].to_date
        models = models.where('reports.created_at > ?', date_from) if date_from
        models = models.where('reports.created_at < ?', date_to) if date_to
        models
      end

      def orders!(options, params:, **)
        models = options['models']
        order = params[:order_asc] == 'true' ? :asc : :desc
        if %w[id created_at updated_at headline report_type completion_status]
           .include?(params[:order])
          models = models.order(params[:order] => order)
        elsif %w[preferred_foot height weight nationality_country_code playing_position]
              .include?(params[:order])
          models = models.sort_by { |r| r.player_field(params[:order]) }
          models = models.reverse if order == :asc
        elsif params[:order] == 'club'
          models = models.sort_by(&:club_name)
        elsif params[:order] == 'competition'
          models = models.sort_by(&:league_name)
        elsif params[:order] == 'category'
          models = models.sort_by(&:category)
        elsif params[:order] == 'player'
          models = models.sort_by(&:player_name)
        elsif params[:order] == 'scout_name'
          models = models.includes(:user)
          models = models.order("users.search_string #{order}")
        elsif params[:order] == 'price'
          models = models.order("reports.price->>'value' #{order}")
        end
        if %w[club competition category player].include?(params[:order])
          models = models.reverse if order == :asc
        end
        options['models'] = models
      end
    end
  end
end
