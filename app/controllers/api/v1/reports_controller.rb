module Api
  module V1
    class ReportsController < Api::V1::BaseController

      def index
       # @current_user.roles.first.name
        if is_scout?
          render json: Report.all, status: response[:status]
        else
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end

      def create
        result = ::V1::Report::Create.(report_params, current_user: current_user)
        if result.success?
          report = Report.find(result['model'].id)
          report_datum = ::V1::ReportDatum::Create.({meta_data: params[':report'],report: report})
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
          render json: response[:data] , status: response[:status]
        else
          render json: {
            error: result['contract.default'].errors.full_messages
          }, status: :unprocessable_entity
        end

      end

      def update

      end



      def is_club?
        #@current_user.role
      end

      def is_scout?
        @current_user.roles.first.name == 'scout'
      end

      def report_params
        params.permit(:headline, :status,:price,:type_report,:player_id)
      end
    end
  end
end
