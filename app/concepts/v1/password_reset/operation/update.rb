module V1
  module PasswordReset
    class Update < Trailblazer::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :update_password!

      private

      def find_model!(options, params:, **)
        byebug
        options['model'] = ::PasswordReminder.find_by_token(params[:token])
      end

      def update_password!(model:, params:, **)
        byebug
        password_digest = Bcrypt::Password.create(params[:password])
        model.user.update_attributes(:password_digest, password_digest)
        ::PasswordReminder.where(user_id: model.user.id).delete_all
        byebug
      end
    end
  end
end
