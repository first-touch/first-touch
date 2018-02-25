module V1
  class DirectUpload
    class SignedUrl < FirstTouch::Operation
      step :init_filename!
      step :init_s3!
      step :build_signed_url!

      private

      def init_filename!(options, params:, **)
        options['filename'] = params[:filename]
      end

      def init_s3!(options, **)
        s3 = Aws::S3::Resource.new(ENV['AWS_REGION'])
        options['s3_bucket'] = s3.bucket(ENV['AWS_BUCKET_NAME'])
      end

      # TODO: Update this method to put the result into model instead of
      # models once the new endpoint is rebased here
      def build_signed_url!(options, filename:, s3_bucket:, **)
        key = "uploads/#{SecureRandom.uuid}/#{filename}"
        params = { acl: 'public-read' }
        obj = s3_bucket.object key

        options['models'] = {
          presigned_url: obj.presigned_url(:put, params),
          public_url: obj.public_url
        }
      end
    end
  end
end
