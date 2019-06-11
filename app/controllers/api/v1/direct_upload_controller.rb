module Api
  module V1
    class DirectUploadController < Api::V1::BaseController
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
    end
  end
end
