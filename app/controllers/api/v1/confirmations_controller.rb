module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      def show
        super do |resource|
          if resource.errors.empty?
            render json: { message: 'Account confirmed' }, status: :ok && return
          else
            render json: resource.errors, status: :unauthorized && return
          end
        end
      end
    end
  end
end
