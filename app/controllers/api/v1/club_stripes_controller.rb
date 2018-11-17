module Api
  module V1
    class ClubStripesController < Api::V1::BaseController
      def show
        result = ::V1::ClubStripe::Show.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::ClubStripe::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::ClubStripe::Create.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::ClubStripe::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def update
        result = ::V1::ClubStripe::Update.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::ClubStripe::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def destroy
        result = ::V1::ClubStripe::Delete.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::ClubStripe::Representer::Full)
        render json: response[:data], status: response[:status]
      end
    end
  end
end
