module V1
  module Note
    class MLUpdate < FirstTouch::NoAuthOperation
      step Model(::Note, :find_by)
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Note::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :note)
      step Trailblazer::Operation::Contract::Persist()
    end
  end
end
