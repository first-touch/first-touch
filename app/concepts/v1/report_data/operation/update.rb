module V1
  module ReportDatum
    class Update < Trailblazer::Operation
      step :find_model!
      # failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build( constant: ReportDatum::Contract::Update )
      step :setup_model!
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private
      def find_model!(options, params:, **)
        options['model'] = model = params[:report_data]
        options['model.class'] = ::Report
        true
      end

      def setup_model!(options, params:, **)
        if !params[:attachments].blank?
          model = options['model']
          model.attachments = params[:attachments]
        end
      end
    end
  end
end