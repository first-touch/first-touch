module V1
  module Order
    class CreateBidOrder < Trailblazer::Operation
      step Model(::Order, :new)
      step Trailblazer::Operation::Contract::Build(
        constant: Order::Contract::CreateBidOrder
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
