module V1
  module Report
    class Update < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step :update_attachments!
      step Trailblazer::Operation::Contract::Persist()

      private

      def find_model!(options, params:, current_user:, **)
        options['model.class'] = ::Report
        options['model'] = current_user.reports.find_by(id: params[:id])
      end

      def update_attachments!(model:, params:, **)
        unless params['remove_attachment'].blank?
          model.attachments.where(id: params['remove_attachment'].keys).destroy_all
        end
      end
    end
  end
end
