Aws.config.update({
  region: Rails.application.secrets.FT_AWS_REGION,
  credentials: Aws::Credentials.new(Rails.application.secrets.FT_AWS_ACCESS_KEY,
                                    Rails.application.secrets.FT_AWS_SECRET_KEY
                                   ),
})

S3_BUCKET = Aws::S3::Resource.new.bucket(Rails.application.secrets.FT_AWS_S3_BUCKET_NAME)
