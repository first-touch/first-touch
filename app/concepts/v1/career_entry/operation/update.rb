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

      def owns_career_entry?(options, current_user:, **)
        return true if model.user_id == current_user.id
        false
      end

      def wrong_owner!(options, **)
        error_message = I18n.t 'career.invalid_owner'
        options['result.policy.failure'] = [error_message]
      end

      def setup_club!(options, params:, **)
        club_id = params[:career_entry][:club_id]
        return true unless club_id
        model.club = ::Club.find_by id: club_id
      end

      def setup_user!(options, current_user:, **)
        model.user = current_user
        true
      end
    end
  end
end
