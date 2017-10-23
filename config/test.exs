use Mix.Config

# Test configuration
config :s3_direct_upload,
  aws_access_key: "123abc",
  aws_secret_key: "abc123",
  aws_s3_bucket: "s3-bucket",
  date_util: S3DirectUpload.StaticDateUtil
