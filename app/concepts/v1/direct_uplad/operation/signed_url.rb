module V1
  module DirectUpload
    class SignedUrl < FirstTouch::Operation
      step :init_s3!
      step :build_signed_url!

      private

      def init_s3!(options, **)
        options['s3_bucket'] = S3_BUCKET
      end

      def build_signed_url!(options, s3_bucket:, **)
        key = "uploads/#{SecureRandom.uuid}"
        params = { acl: 'public-read' }
        obj = s3_bucket.object key
        options['model'] = {
          presigned_url: obj.presigned_url(:put, params),
          public_url: obj.public_url
        }
      end
    end
  end
end
