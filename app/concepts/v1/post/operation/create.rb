module V1
  module Post
    class Create < Trailblazer::Operation
      step :find_authorable!
      step :authorized_to_post!
      failure :unauthorized!, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Post::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :post)
      step Trailblazer::Operation::Contract::Persist()

      def find_authorable!(options, params:, **)
        params.each do |name, value|
          next unless name =~ /(.+)_id$/
          options['author'] = Regexp.last_match(1)
                                    .classify
                                    .constantize
                                    .find(value)
          return options
        end
        false
      end

      def authorized_to_post!(author:, current_user:, **)
        return author == current_user if author.class.name == 'User'
        author.account_owner == current_user
      end

      def setup_model!(options, **)
        options['model'] = ::Post.new
        options['model'].author = options['author']
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end
    end
  end
end
