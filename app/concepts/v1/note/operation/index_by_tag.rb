module V1
  module Note
    class IndexByTag < Trailblazer::Operation
      step :setup_model!

      def setup_model!(options, params:, current_user:, **)
        # need to customize query to prevent N+1
        options['models'] = current_user.notes.joins(:tags).where('tags.name = ?', params['tag'])
        true
      end
    end
  end
end
