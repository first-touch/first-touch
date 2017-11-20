module Api::V1
  class PasswordResetController < Api::V1::BaseController

    def create
      result = FirstTouch::Endpoint.(
        ::V1::PasswordReset::Request,
        args: [params]
      )
      render json: result[:data], status: result[:status]
    end
