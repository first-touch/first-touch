module V1
  module Report
    class Show < FirstTouch::Operation
      step :find_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Create
      )
      step Trailblazer::Operation::Contract::Persist()

      private

      def find_model!(options, params:, current_user:, **)
        options['model'] = model = current_user.reports.find_by(id: params[:id])
        options['result.model.test'] = options['model'].report_data.last
        options['model.class'] = ::Report
        options['result.model'] = result = Result.new(!model.nil?, {})
      end
    end
  end
end
