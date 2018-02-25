module Api
  module V1
    class DirectUploadController < Api::V1::BaseController
      # TODO: Update controller to match the new endpoint logic
      def signed_url
        FirstTouch::Endpoint.(
          ::V1::DirectUpload::SignedUrl,
          args: [params, current_user: current_user],
          representer: ::V1::DirectUpload::SignedUrl
        )
        render json: response[:data], status: response[:status]
      end
    end
  end
end
