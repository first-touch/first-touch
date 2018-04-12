module V1
  module Request
    class Show < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true

      private

      def find_model!(options, params:, current_user:, **)
        model = current_user.requests.find(params[:id])
        options['model.class'] = ::Request
        options['model'] = model
      end
    end
  end
end
