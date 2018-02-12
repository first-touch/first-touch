module V1
  module Note
    class Labels < Trailblazer::Operation
      step :get_labels!

      def get_labels!(options, current_user:, **)
        labels = current_user.notes.inject([]) do |labels, note|
          labels + note.labels
        end
        options['models'] = labels.uniq
        true
      end
    end
  end
end
