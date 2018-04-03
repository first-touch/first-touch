require './lib/file_upload_util'

module Api
  module V1
    class ReportsController < Api::V1::BaseController

      def index
        result = ::V1::Report::Index.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Index)
          render json: response[:data], status: response[:status]
        else
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end

      def purchased
        result = ::V1::Report::Purchased.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Index)
          render json: response[:data], status: response[:status]
        else
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end

      def show
        result = ::V1::Report::Show.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
          render json: { report: response[:data], owner: current_user.reports.where(id: params[:id]).present? } , status: response[:status]
        else
          render json: {
          }, status: :unauthorized
        end
      end

      def create
        result = ::V1::Report::Create.(params, current_user: current_user)
        if result.success?
          report = Report.find(result['model'].id)
          report_datum = ::V1::ReportDatum::Create.({meta_data: params['report_data'],report: report})
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
            report_datum =  report.report_data.find_by version: params[:report_version]
          else
            report_datum =  report.report_data.last
          end
          params['files'].each do |key|
            name = params['files'][key].original_filename
            path = FileUploadUtil.save_file(params['files'][key], report.id.to_s,report_datum.version.to_s)
            result = ::V1::Attachment::Create.({url:path, filename: name, report_data: report_datum},current_user: current_user)
          end
          render json: nil , status: :ok
        end
      end

      def download
        result = ::V1::Attachment::Find.(params, current_user: current_user)
        attachment = result['model']
        if (attachment.blank?)
          render json: nil , status: :not_found
        else
            send_file(attachment.url,
              :filename => attachment.filename)
        end
      end

      def update
        result = ::V1::Report::Update.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
          render json: response[:data] , status: response[:status]
        else
          render json: {
            error: (result['contract.default'].blank?) ? "Sorry but something went wrong" : result['contract.default'].errors.full_messages
          }, status: :unprocessable_entity
        end
      end


    end
  end
end
