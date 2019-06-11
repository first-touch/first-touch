module Api
  module V1
    class DirectUploadController < Api::V1::BaseController
      def create
        blob = ActiveStorage::Blob.create_before_direct_upload!(blob_args)
        render json: direct_upload_json(blob)
      end

      def signed_request
        key = "uploads/#{Time.now.to_i}/#{params[:filePath]}"
        aws_params = { acl: 'public-read', key: key, success_action_status: '201' }
        post = S3_BUCKET.presigned_post(aws_params)
        data = {
          "postEndpoint": post.url,
          "signature": post.fields
        }
        render json: data, status: :ok
      end

      def signed_url
        res = ::V1::DirectUpload::SignedUrl.(params: params, current_user: current_user)
        render json: res[:model], status: :ok
      end

      private

      def blob_args
        params.require(:blob).permit(:filename, :byte_size, :checksum, :content_type, :metadata).to_h.symbolize_keys
      end

      def direct_upload_json(blob)
        blob.as_json(root: false, methods: :signed_id).merge(
          direct_upload: {
            url: blob.service_url_for_direct_upload,
            headers: blob.service_headers_for_direct_upload
          }
        )
      end
    end
  end
end
