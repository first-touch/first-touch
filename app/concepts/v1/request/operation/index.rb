module V1
  module Request
    class Index < FirstTouch::Operation
      step :find_model!
      step :filters!
      step :orders!
      private

      def find_model!(options, params:, current_user:, **)
        if is_scout? current_user
          models = ::Request.all.where status: 'publish'
        elsif is_club? current_user
          models = current_user.requests.where.not(status: 'deleted')
        end
        options['models'] = models
        models.length > 0 ? true : false
      end

      def filters!(options, params:, current_user:, **)
          models = options['models']
          models = models.where id: params[:id] if !params[:id].blank?
          models = models.where type_request: params[:type_request] if !params[:type_request].blank?
          models = models.where status: params[:status] if !params[:status].blank?

          date = params[:created_date].to_date if !params[:created_date].blank?
          if date
            models = models.where :created_at => date.all_day
          end
        options['models'] = models
        true
      end

      def orders!(options, params:, current_user:, **)
        models = options['models']
        if params[:order] == 'id'
          models = models.order(:id)
        elsif params[:order] == 'type_request'
          models = models.order(:type_request)
        elsif params[:order] == 'status'
          models = models.order(:status)
        elsif params[:order] == 'created_on'
          models = models.order(:created_at)
        elsif params[:order] == 'nb_bids'
          models = models.order(:id)
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
