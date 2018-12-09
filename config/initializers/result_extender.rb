module Trailblazer
  class Operation
    class Result
      def errors
        return self[:errors] unless self[:errors].blank?
        return self['result.policy.failure'] if policy_error?
        return self['contract.default'].errors.messages.values if contract_error?
        return self['result.model'] if model_error?
      end

      def policy_error?
        self['result.policy.failure'].present?
      end

      def unauthenticated?
        policy_error? && self['result.policy.failure'] == :unauthenticated
      end

      def unauthorized?
        policy_error? && self['result.policy.failure'] == :unauthorized
      end

      def model_error?
        self['result.model'].present?
      end

      def contract_error?
        self['contract.default'].present?
      end
    end
  end
end
