module V1
  module StripeTransaction
    class Create < Trailblazer::Operation
      step Model(::StripeTransaction, :new)
      step Trailblazer::Operation::Contract::Build(
        constant: StripeTransaction::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
