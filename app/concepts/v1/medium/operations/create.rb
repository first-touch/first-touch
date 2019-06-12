module V1
  module Medium
    class Create < FirstTouch::Operation
      step :validate_user
      failure :unauthorized!, fail_fast: true
      step :prepare_file_metadata
      step :download_image
      step :attach_image_to_user

      def validate_user(_options, current_user:, params:, **)
        current_user.id == params[:user_id].to_i
      end

      def prepare_file_metadata(options, params:, **)
        uri = URI.parse(params[:media_url])
        options[:filename] = File.basename(uri.path)
      end

      def download_image(options, params:, **)
        options[:image] = open(params[:media_url])
      end

      def attach_image_to_user(options, current_user:, **)
        options[:model] = current_user.media.attach(
          io: options[:image],
          filename: options[:filename]
        )[0]
      end
    end
  end
end
