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
      step :set_ownership!

      def setup_model!(model:, current_user:, **)
        model.user = current_user
        true
      end

      def set_ownership!(params:, model:, current_user:, **)
        current_user.tag(model, with: params[:note]["tag_list"], on: :tags, skip_save: true)
        true
      end
    end
  end
end