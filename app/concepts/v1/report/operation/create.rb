module V1
  module Report
    class Create < Trailblazer::Operation
      step Model(::Report, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(model:, current_user:, **)
        model.user = current_user
      end
    end
  end
end
