module Api
  module V1
    class FilesController < Api::V1::BaseController
      BUCKET_NAME = "first-touch"
      TIME_TO_ACCESS = 2.minutes

      def new
        resource.bucket(Rails.application.secrets.FT_AWS_S3_BUCKET_NAME)
        params = { acl: 'public-read' }
        filename = params.fetch(:filename)
        key = "uploads/#{filename}"
        obj = resource.object key

        render json: {
          upload_url: obj.presigned_url(:put, params)
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
        @client ||= Aws::S3::Client.new(
          region: Rails.application.secrets.FT_AWS_REGION
        )
      end

      def resource
        @resource ||= Aws::S3::Resource.new(client: client)
      end
    end
  end
end
