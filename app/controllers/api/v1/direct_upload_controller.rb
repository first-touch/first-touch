module Api
  module V1
    class DirectUploadController < Api::V1::BaseController
      def signed_url
        res = ::V1::DirectUpload::SignedUrl.(params, current_user: current_user)
        render json: res['model'], status: :ok
      end
    end
  end
end
