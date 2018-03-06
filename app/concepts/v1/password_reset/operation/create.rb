module V1
  module PasswordReset
    class Create < Trailblazer::Operation
      step Model(::PasswordReminder, :new)
      step :setup_model
      step :remove_invalid_tokens
      step Trailblazer::Operation::Contract::Build(
        constant: PasswordReset::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :send_password_reset_email

      def setup_model(model:, params:, **)
        model.user = ::User.find_by(email: params[:email])
        model.token = SecureRandom.urlsafe_base64
        model.expires_at = 1.hour.from_now
      end

      def remove_invalid_tokens(model:, **)
        ::PasswordReminder.where(user_id: model.user.id).delete_all
        ::PasswordReminder.where("expires_at < ?", DateTime.now).delete_all
      end

      def send_password_reset_email(options)
        # UserMailer.password_reset(model).deliver_later
        true
      end
    end
  end
end
