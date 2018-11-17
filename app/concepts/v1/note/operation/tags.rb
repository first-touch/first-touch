module V1
  module Note
    class Tags < Trailblazer::Operation
      step :get_tags!

      def get_tags!(options, **)
        tags = options[:current_user].owned_tags.pluck(:name)
        options['models'] = tags
        true
      end
    end
  end
end
