module V1
  module Post
    class Create < FirstTouch::Operation
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Post::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :post)
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(options, current_user:, **)
        options['model'] = ::Post.new
        options['model'].author = current_user
      end
    end
  end
end
