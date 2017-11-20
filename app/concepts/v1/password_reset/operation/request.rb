require 'bcrypt'

module V1
  module PasswordReset
    class Request < Trailblazer::Operation
      step Model(::PasswordReminder, :new)
      step Trailblazer::Operation::Contract::Build(
        constant: PasswordReset::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      failure :not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Persist()
      step :remove_existing_tokens
      step :generate_token
      step :set_expiry_timestamp
      step :associate_user
      step :send_password_reset_email
      step :remove_expired_tokens

      def remove_existing_tokens(options, **)
        PasswordReminder.delete_all(user_id: options['contract.default'].user.id)
      end

      def generate_token(options, **)
        model.token = SecureRandom.urlsafe_base64
      end

      def set_expiry_timestamp(options, **)
        model.expires_at = Time.now + 1.hour
      end

      def associate_user(options, **)
        options['model'].user = options['contract.default'].user
      end

      def send_password_reset_email(options, **)
        # UserMailer.password_reset(model).deliver_later
      end

      def remove_expired_tokens(options, **)
        PasswordReminder.delete_all("expires_at < '#{Time.now}'")
      end

      def not_found!(options, **)
        options['result.contract.errors'] = :not_founds
      end
    end
  end
end
