module V1
  module Report
    class Create < Trailblazer::Operation
      step Model(::Report, :new)
      step Trailblazer::Operation::Contract::Build(constant: Report::Contract::Create)
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

    end
  end
end