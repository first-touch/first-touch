module Api
  module V1
    class MediaController < Api::V1::BaseController
      def create
        res = ::V1::Medium::Create.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(res, ::V1::Medium::Representer::Show)
        render json: response[:data], status: response[:status]
      end

      def destroy
        res = ::V1::Medium::Destroy.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(res)
        render json: response[:data], status: response[:status]
      end
    end
  end
end
