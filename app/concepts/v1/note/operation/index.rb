module V1
  module Note
    class Index < Trailblazer::Operation
      step :setup_model!

      def setup_model!(options, current_user:, **)
        options['models'] = current_user.notes.includes(:tags)
      end
    end
  end
end
