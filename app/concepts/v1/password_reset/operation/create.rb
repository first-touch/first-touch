require 'bcrypt'

module V1
  module PasswordReset
    class Create < Trailblazer::Operation
      step Model(::PasswordReminder, :new)
      step :associate_user!
      step :remove_existing_tokens
      step :generate_token
      step :set_expiry_timestamp
      step :send_password_reset_email
      step :remove_expired_tokens
      step Trailblazer::Operation::Contract::Build(
        constant: PasswordReset::Contract::Create
      )
      step :log_build!, fail_fast: true
      step Trailblazer::Operation::Contract::Validate(key: :email)
      step :log_validate!, fail_fast: true
      step Trailblazer::Operation::Contract::Persist()

      def log_build!(options, **)
        byebug
        options['result.policy.failure'] = 'contract did not build'
      end

      def log_validate!(options, **)
        byebug
        options['result.policy.failure'] = 'contract did not validate'
      end

      def associate_user!(model:, params:, **)
        model.user = ::User.find_by(email: params[:email])
      end

      def remove_existing_tokens(model:, **)
        ::PasswordReminder.where(user_id: model.user.id)
        .delete_all
      end

      def generate_token(model:, **)
        model.token = SecureRandom.urlsafe_base64
      end

      def set_expiry_timestamp(model:, **)
        model.expires_at = Time.now + 1.hour
      end

      def send_password_reset_email(options, **)
        # UserMailer.password_reset(model).deliver_later
      end

      def remove_expired_tokens(**)
        ::PasswordReminder.where("expires_at < '#{Time.now}'")
        .delete_all
      end
    end
  end
end
