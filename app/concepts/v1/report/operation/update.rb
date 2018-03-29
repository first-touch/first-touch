module V1
  module Report
    class Update < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :update_data!
      private

      def find_model!(options, params:, current_user:, **)
        options['model'] = model = current_user.reports.find_by(id: params[:id])
        options['model.class'] = ::Report
        if model.nil?
          false
        else
          if !params[:status].blank?
            model.status = params[:status]
          end
          true
        end
      end

      def update_data!(model:, params:, current_user:, **)

        if !params[:report_data].blank?
          remove_ids = params['remove_attachment'].keys  if !params['remove_attachment'].blank?
          attachments = []
          attachments = model.report_data.last.attachments.where.not(id: remove_ids)
          ::V1::ReportDatum::Update.({meta_data: params['report_data'], report: model, report_data: model.report_data.last,  attachments: attachments })
        else
          true
        end
      end
    end
  end
end
