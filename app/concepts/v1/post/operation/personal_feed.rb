module V1
  module Post
    class PersonalFeed < FirstTouch::Operation
      step :build_feed

      def build_feed(options, **)
        options['models'] = ::Post.where(
          author_id: relevant_user_ids(options[:current_user]),
          author_type: 'User'
        ).order('updated_at DESC')
        true
      end

      private

      def relevant_user_ids(current_user)
        [current_user.id] + current_user.following_ids
      end
    end
  end
end
