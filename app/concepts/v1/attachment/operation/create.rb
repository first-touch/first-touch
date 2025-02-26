module V1
  module Attachment
    class Create < Trailblazer::Operation
      step Model(::Attachment, :new)
      step Trailblazer::Operation::Contract::Build(
        constant: Attachment::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
