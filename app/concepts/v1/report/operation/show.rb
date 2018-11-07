module V1
  module Report
    class Show < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true

      private

      def find_model!(options, params:, current_user:, current_club:, **)
        model = nil
        if current_user.scout?
          model = current_user.reports.find(params[:id])
        elsif !current_club.nil?
          free_report = ::Report.find_by("(price->>'value')::int = 0 and id = ?", params[:id])
          if !free_report.nil?
            model = free_report
          else
            order = current_club.reports_buy.find_by(report_id: params[:id],
                                                     status: 'completed')
            model = order.report unless order.blank?
          end
        end
        options['model.class'] = ::Report
        options[:model] = model
      end
    end
  end
end
