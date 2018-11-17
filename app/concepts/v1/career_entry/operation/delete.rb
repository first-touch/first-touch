module V1
  module CareerEntry
    class Delete < FirstTouch::Operation
      step Model(::CareerEntry, :find_by)
      failure :model_not_found!, fail_fast: true
      step Policy::Guard(:owns_career_entry?, name: :owns_career_entry)
      failure :wrong_owner!, fail_fast: true
      step :destroy!

      private

      def owns_career_entry?(options, **)
        return true if options[:model].user_id == options[:current_user].id
        false
      end

      def wrong_owner!(options, **)
        error_message = I18n.t 'career.invalid_owner'
        options['result.policy.failure'] = [error_message]
      end

      def destroy!(options, **)
        options['model.action'] = :destroy
        options[:model].destroy
      end
    end
  end
end
