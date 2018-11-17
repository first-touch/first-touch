module V1
  module CareerEntry
    class Update < FirstTouch::Operation
      step Model(::CareerEntry, :find_by)
      failure :model_not_found!, fail_fast: true
      step Policy::Guard(:owns_career_entry?, name: :owns_career_entry)
      failure :wrong_owner!, fail_fast: true
      step :setup_club!
      step Trailblazer::Operation::Contract::Build(
        constant: CareerEntry::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate(key: :career_entry)
      step Trailblazer::Operation::Contract::Persist()

      def owns_career_entry?(options, **)
        return true if options[:model].user_id == options[:current_user].id
        false
      end

      def wrong_owner!(options, **)
        error_message = I18n.t 'career.invalid_owner'
        options['result.policy.failure'] = [error_message]
      end

      def setup_club!(options, params:, **)
        club_id = params[:career_entry][:club_id]
        return true unless club_id
        options[:model].club = ::Club.find_by id: club_id
      end

      def setup_user!(options, **)
        options[:model].user = options[:current_user]
        true
      end
    end
  end
end
