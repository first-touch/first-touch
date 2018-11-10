module V1
  module Event
    class Index < Trailblazer::Operation
      step :setup_model!

      # FIXME: Find a way to handle multiple clubs managed by a user
      def setup_model!(options,  **)
        managed_clubs = options[:current_user].managed_clubs
        if managed_clubs.count.zero?
          options['models'] = []
          return true
        end
        options['models'] = managed_clubs.first.events
        true
      end
    end
  end
end
