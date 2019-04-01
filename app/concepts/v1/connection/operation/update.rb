module V1
  module Connection
    class Update < FirstTouch::Operation
      step Model(::Connection, :find_by)
      step Trailblazer::Operation::Contract::Build(
        constant: Connection::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
