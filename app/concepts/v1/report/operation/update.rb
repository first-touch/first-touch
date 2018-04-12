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
      end

      def update_data!(model:, params:, current_user:, **)
        if !params['remove_attachment'].blank?
          model.reports.attachments.destroy(params['remove_attachment'].keys)
        end
        true
      end
    end
  end
end
