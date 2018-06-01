module Api
  module V1
    class FilesController < Api::V1::BaseController
      BUCKET_NAME = "first-touch"
      TIME_TO_ACCESS = 2.minutes

      def new
        upload_url = client.put_object_url(
          BUCKET_NAME,
          params.fetch(:filename),
          TIME_TO_ACCESS.from_now.to_i
        )

        render json: {
          upload_url: upload_url
        }
      end

      def show
        download_url = client.get_object_url(
          BUCKET_NAME,
          params.fetch(:filename),
          TIME_TO_ACCESS.from_now.to_i
        )

        render json: {
          download_url: download_url
        }
      end

      private

      def client
        @client ||= Fog::Storage::AWS.new(...)
      end

      # TODO: to be changed once s3 is set
      def upload_files
        result = ::V1::Attachment::Add.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Order::Representer::Empty)
        render json: response[:data], status: response[:status]
      end
    end
  end
end
