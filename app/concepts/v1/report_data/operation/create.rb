module V1
  module ReportDatum
    class Create < Trailblazer::Operation
      step Model(::ReportDatum, :new)
      step Trailblazer::Operation::Contract::Build( constant: ReportDatum::Contract::Create )
      step :setup_model!
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private
      def setup_model!(options, params:, **)
        brothers = ::ReportDatum.where(report: params[:report])
      end
    end
  end
end
