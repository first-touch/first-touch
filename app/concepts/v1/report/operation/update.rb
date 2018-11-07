module V1
  module Report
    class Update < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step :destroy_attachments!
      step Trailblazer::Operation::Contract::Persist()
      step :persist_files!

      private

      def find_model!(options, params:, current_user:, **)
        options['model.class'] = ::Report
        options[:model] = current_user.reports.find_by(id: params[:id])
      end

      def persist_files!(options, params:, current_user:, **)
        if !params[:files].blank?
          params[:files].each do |file|
            file_params = { url: file[:url], filename: file[:filename], report: model }
            result = ::V1::Attachment::Create.(params: file_params, current_user: current_user)
          end
        end
        true
      end

      def destroy_attachments!(options, params:, **)
        unless params['remove_attachment'].blank?
          model.attachments.where(id: params['remove_attachment'].keys).destroy_all
        end
        true
      end
    end
  end
end
