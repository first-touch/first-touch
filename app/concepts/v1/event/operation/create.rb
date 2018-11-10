module V1
  module Event
    class Create < Trailblazer::Operation
      step :authorized!
      failure :unauthorized!, fail_fast: true
      step Model(::Event, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Event::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :event)
      step Trailblazer::Operation::Contract::Persist()

      def authorized!( **)
        options[:current_user].managed_clubs.count.positive?
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end

      # FIXME: Find a way to handle multiple clubs managed by a user
      def setup_model!(options, params:,  **)
        options[:model].organizer_id = options[:current_user].managed_clubs.first.id
        return true unless params['opponent_id']
        options[:model].opponent = ::Club.find_by(id: params['opponent_id'])
        true
      end
    end
  end
end
