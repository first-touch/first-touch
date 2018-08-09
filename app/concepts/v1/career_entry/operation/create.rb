module V1
  module CareerEntry
    class Create < FirstTouch::Operation
      step Model(::CareerEntry, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: CareerEntry::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :club)
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(model:, current_user:, **)
        model.user_id = current_user.id
      end
    end
  end
end
