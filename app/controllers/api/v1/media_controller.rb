module Api
  module V1
    class MediaController < Api::V1::BaseController
      def create
        res = ::V1::Medium::Create.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(res)
        render json: response[:data], status: response[:status]
      end

      def destroy
        u = User.find_by(id: params['user_id'])
        media_id = params['id']
        media = u.media.find media_id
        media.purge
        render json: {}, status: :ok
      end
    end
  end
end
