module V1
  module Request
    class Show < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true

      private

      def find_model!(options, params:, current_user:, **)
        model = current_user.requests.where(id: params[:id]).where.not(status: 'deleted').first
        options['model.class'] = ::Request
        options['model'] = model
      end
    end
  end
end
