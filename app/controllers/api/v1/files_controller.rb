module Api
  module V1
    class FilesController < Api::V1::BaseController
      # TODO: to be changed once s3 is set
      def upload_files
        result = ::V1::Attachment::Add.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Order::Representer::Empty)
        render json: response[:data], status: response[:status]
      end
    end
  end
end
