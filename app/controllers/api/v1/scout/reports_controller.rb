module Api
  module V1
    module Scout
      # TODO: the create, update and show controllers are sending a messed up data
      # this should be updated and matched on the front end side.
      class ReportsController < Api::V1::BaseController
        def index
          result = ::V1::Report::Operation::Scout::Index.(params: params, current_user: current_user)
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Index)
          render json: response[:data], status: response[:status]
        end

        def show
          result = ::V1::Report::Operation::Scout::Show.(params: params, current_user: current_user)
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
          render json: { report: response[:data], owner: current_user.scout? }, status: response[:status]
        end

        def create
          result = ::V1::Report::Operation::Scout::Create.(params: params, current_user: current_user)
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
          render json: { report: response[:data], owner: current_user.scout? }, status: response[:status]
          # render json: response[:data], status: response[:status]
        end

        def update
          result = ::V1::Report::Operation::Scout::Update.(
            params: params,
            current_user: current_user
            )
            response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
          render json: { report: response[:data], owner: current_user.scout? }, status: response[:status]
          # render json: response[:data], status: response[:status]
        end
      end
    end
  end
end
