require './lib/file_upload_util'

module Api
  module V1
    class ReportsController < Api::V1::BaseController

      def index
        if is_scout?
          render json: Report.all, status: response[:status]
        else
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end

      def show
        result = ::V1::Report::Show.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::Report::Create.(report_params, current_user: current_user)
        if result.success?
          report = Report.find(result['model'].id)
          report_datum = ::V1::ReportDatum::Create.({meta_data: params['report'],report: report})
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
          render json: response[:data] , status: response[:status]
        else
          render json: {
            error: result['contract.default'].errors.full_messages
          }, status: :unprocessable_entity
        end
      end


    def upload_files
      if (params[:report_id])
        report =  @current_user.reports.find(params[:report_id])
        if params[:report_version]
          @current_user
          report_datum =  report.report_data.find_by version: params[:report_version]
        else
          report_datum =  report.report_data.last
        end
        params['files'].each do |key|
          path = FileUploadUtil.save_file(params['files'][key], report.id.to_s,report_datum.version.to_s)
          result = ::V1::Attachment::Create.({url:path, report_data: report_datum},current_user: current_user)
        end
        render json: nil , status: :ok
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
