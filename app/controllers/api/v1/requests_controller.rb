module Api
  module V1
    class RequestsController < Api::V1::BaseController
      def index
        result = ::V1::Request::Index.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def show
        result = ::V1::Request::Show.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::Request::Create.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def update
        result = ::V1::Request::Update.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
        render json: response[:data], status: response[:status]
      end
    end
  end
end
