require 'bcrypt'

module V1
  module PasswordReset
    class Request < Trailblazer::Operation
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
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()


      def associate_user!(options, params, **)
        options['model'].user = ::User.find_by!(email: params[:email])
      end

      def remove_existing_tokens(options, **)
        PasswordReminder.delete_all(user_id: options['model'].user.id)
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
        PasswordReminder.delete_all("expires_at < '#{Time.now}'")
      end
    end
  end
end
