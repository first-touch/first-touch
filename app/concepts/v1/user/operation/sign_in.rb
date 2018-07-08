module V1
  module User
    class SignIn < Trailblazer::Operation
      step :find_user!
      failure :unauthenticated_user!

      def find_user!(options, params:, **)
        options['model'] = ::User.find_by(email: params[:email])
        options['model']&.valid_password? params[:password]
      end
    end
  end
end
