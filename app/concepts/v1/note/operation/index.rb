module V1
  module Note
    class Index < Trailblazer::Operation
      step :setup_model!

      def setup_model!(options, current_user:, **)
        options['model'] = current_user.notes
        true
      end
    end
  end
end
