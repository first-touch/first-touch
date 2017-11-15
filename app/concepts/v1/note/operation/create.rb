module V1
  module Note
    class Create < Trailblazer::Operation
      step Model(::Note, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Note::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :note)
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(model:, current_user:, **)
        model.user = current_user
        true
      end
    end
  end
end
