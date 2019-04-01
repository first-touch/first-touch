module V1
  module Connection
    class Create < FirstTouch::Operation
      step Model(::Connection, :new)
      step Trailblazer::Operation::Contract::Build(
        constant: Connection::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
