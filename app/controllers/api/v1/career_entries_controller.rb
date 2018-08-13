module Api
  module V1
    class CareerEntriesController < Api::V1::BaseController
      def create
        result = ::V1::CareerEntry::Create.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::CareerEntry::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def update
        result = ::V1::CareerEntry::Update.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::CareerEntry::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def destroy
        result = ::V1::CareerEntry::Delete.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result)
        render json: response[:data], status: response[:status]
      end
    end
  end
end
