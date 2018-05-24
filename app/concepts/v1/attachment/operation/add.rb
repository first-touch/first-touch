require './lib/file_upload_util'

module V1
  module Attachment
    class Add < Trailblazer::Operation
      step :setup_report!
      step :setup_bid!

      # Todo: will be remove once s3 upload is set
      def setup_report!(options, params:, current_user:, **)
        if params[:report_id]
          report = current_user.reports.find(params[:report_id])
          params['files'].each do |key|
            name = params['files'][key].original_filename
            path = FileUploadUtil.save_file(params['files'][key], report.id.to_s, 'report')
            ::V1::Attachment::Create.({ url: path, filename: name, report: report }, current_user: current_user)
          end
        end
        true
      end
      def setup_bid!(options, params:, current_user:, **)
        if params[:job_id]
          bid = current_user.request_bids.find_by(request_id: params[:job_id], status: 'canceled')
          params['files'].each do |key|
            name = params['files'][key].original_filename
            path = FileUploadUtil.save_file(params['files'][key], bid.id.to_s, 'bid')
            ::V1::Attachment::Create.({ url: path, filename: name, bid: bid }, current_user: current_user)
          end
        end
        true
      end
    end
  end
end
