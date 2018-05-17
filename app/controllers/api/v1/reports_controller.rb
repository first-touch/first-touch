require './lib/file_upload_util'

module Api
  module V1
    class ReportsController < Api::V1::BaseController
      def index
        result = ::V1::Report::Index.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def show
        result = ::V1::Report::Show.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
        render json: { report: response[:data], owner: current_user.scout? }, status: response[:status]
      end

      def create
        result = ::V1::Report::Create.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      # Todo:to be change once s3 is set
      def upload_files
        if params[:report_id]
          report = @current_user.reports.find(params[:report_id])
          params['files'].each do |key|
            name = params['files'][key].original_filename
            path = FileUploadUtil.save_file(params['files'][key], report.id.to_s)
            ::V1::Attachment::Create.({ url: path, filename: name, report: report }, current_user: current_user)
          end
          render json: nil, status: :ok
        end
      end

      # Todo:to be change once s3 is set
      def download
        result = ::V1::Attachment::Find.(params, current_user: current_user)
        attachment = result['model']
        if attachment.blank?
          render json: nil, status: :not_found
        else
          send_file(attachment.url, filename: attachment.filename)
        end
      end

      def update
        result = ::V1::Report::Update.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Report::Representer::Full)
        render json: response[:data], status: response[:status]
      end

    end
  end
end
