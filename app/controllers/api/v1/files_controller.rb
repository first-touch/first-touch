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
        # @client ||= Fog::Storage::AWS.new(...)
        nil
      end
    end
  end
end
