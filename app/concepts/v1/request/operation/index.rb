module V1
  module Request
    class Index < FirstTouch::Operation
      step :find_model!
      step :filters!
      step :orders!

      private

      def find_model!(options, current_user:, **)
        if current_user.is_a?(::User) && current_user.scout?
          models = ::Request.all.where status: 'publish'
        elsif current_user.is_a?(::Club) || true
          # @Todo or true need to be remove when club are ready
          models = current_user.requests.where.not(status: 'deleted')
        end
        options['models'] = models
        !models.empty?
      end

      def filters!(options, params:, **)
        models = options['models']
        models = models.where id: params[:id] unless params[:id].blank?
        unless params[:type_request].blank?
          models = models.where type_request: params[:type_request]
        end
        unless params[:status].blank?
          models = models.where status: params[:status]
        end
        date = params[:created_date].to_date unless params[:created_date].blank?
        models = models.where created_at: date.all_day if date
        options['models'] = models
        true
      end

      def orders!(options, params:, **)
        models = options['models']
        if !params[:order].blank? &&
           %w[id type_request status created_at nb_bids report_type]
           .include?(params[:order])
          models = models.order params[:order].to_sym
        end
        options['models'] = models
        true
      end
    end
  end
end
