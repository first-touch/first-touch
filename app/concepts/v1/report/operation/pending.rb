module V1
  module Report
    class Pending < FirstTouch::Operation
      step Model(::Report, :new)
      step Trailblazer::Operation::Contract::Build(
        constant: Report::Contract::Pending
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
