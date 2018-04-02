module V1
  module PasswordReset
    class Request < Trailblazer::Operation
      step Model(::PasswordReminder, :new)
      step :setup_model
      step :remove_invalid_tokens
      step Trailblazer::Operation::Contract::Build(
        constant: PasswordReset::Contract::Request
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :send_password_reset_email

      def setup_model(model:, params:, **)
        user = ::User.find_by(email: params[:email])
        return false unless user
        model.user_id = user.id
        model.token = SecureRandom.urlsafe_base64
        model.expires_at = 1.hour.from_now
      end

      def remove_invalid_tokens(model:, **)
        ::PasswordReminder.where(user_id: model.user_id).delete_all
        ::PasswordReminder.where('expires_at < ?', Time.now).delete_all
        true
      end

      def send_password_reset_email(model:, params:, **)
        UserMailer.password_reset(params[:email], model.token).deliver
      end
    end
  end
end
