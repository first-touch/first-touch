module Api
  module V1
    class MediaController < Api::V1::BaseController
      # TODO: Migrate this to an operation and clean up code
      def create
        u = User.find_by(id: params['user_id'])
        url = params['media_url']
        uri = URI.parse(url)
        downloaded_image = open(url)
        u.media.attach(io: downloaded_image, filename: File.basename(uri.path))
        render json: {}, status: :ok
      end
    end
  end
end
