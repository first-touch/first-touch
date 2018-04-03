module V1
  module Report
    class Show < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      private

      def find_model!(options, params:, current_user:, **)
        model = nil
        if is_scout? current_user
          model = current_user.reports.find(params[:id])
        elsif is_club? current_user
          order = current_user.reports_buy.find_by(report_id: params[:id], status: "completed")
          if !order.blank?
            model = order.report
          end
        end
        options['model.class'] = ::Report
        options['model'] = model
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
