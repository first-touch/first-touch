module V1
  module Post
    class Create < FirstTouch::Operation
      step Model(::Post, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Post::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :post)
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(options, current_user:, **)
        model.author = current_user
      end
    end
  end
end
