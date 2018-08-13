module V1
  module CareerEntry
    class Delete < OPL::Operation
      step Model(::CareerEntry, :find_by)
      failure :model_not_found!, fail_fast: true
      step Policy::Guard(:owns_career_entry?, name: :owns_career_entry)
      failure :wrong_owner!, fail_fast: true
      step :destroy!

      private

      def owns_career_entry?(current_user:, model:, **)
        return true if model.user_id == current_user.id
        false
      end

      def wrong_owner!(options, **)
        error_message = I18n.t 'career.invalid_owner'
        options['result.policy.failure'] = [error_message]
      end

      def destroy!(options, model:, **)
        options['model.action'] = :destroy
        model.destroy
      end
    end
  end
end
