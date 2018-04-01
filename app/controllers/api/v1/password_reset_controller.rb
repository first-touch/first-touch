module Api::V1
  class PasswordResetController < Api::V1::BaseController

    def request
      result = FirstTouch::Endpoint.(
        ::V1::PasswordReset::Request,
        args: [params]
      )
      render json: result[:data], status: result[:status]
    end

    def update
      result = FirstTouch::Endpoint.(
        ::V1::PasswordReset::Update,
        args: [params]
      )
      render json: result[:data], status: result[:status]
    end

    def get_form
      result = FirstTouch::Endpoint.(
        ::V1::PasswordReset::Form,
        args: [params]
      )
      render json: result[:data], status: result[:status]
    end
  end
end
