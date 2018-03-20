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
        options['model'].version = brothers.count + 1
      end
    end
  end
end