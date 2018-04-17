module V1
  module Report
    class Show < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true

      private

      def find_model!(options, params:, current_user:, **)
        model = nil
        if current_user.is_a?(::User) && current_user.scout?
          model = current_user.reports.find(params[:id])
        elsif current_user.is_a?(::Club) || true
          # Todo: or true need to be remove when club are ready
          order = current_user.reports_buy.find_by(report_id: params[:id],
                                                   status: 'completed')
          model = order.report unless order.blank?
        end
        options['model.class'] = ::Report
        options['model'] = model
      end
    end
  end
end
