module V1
  module Report
    class Show < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      private

      def find_model!(options, params:, current_user:, **)
        options['model'] = model = ::Report.where(id: params[:id]).first
        options['model.class'] = ::Report
        (model.blank?)? false : true
      end
    end
  end
end
