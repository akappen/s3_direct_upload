# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# Application configuration
config :s3_direct_upload,
  aws_access_key: System.get_env("AWS_ACCESS_KEY_ID"),
  aws_secret_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  aws_s3_bucket: System.get_env("AWS_S3_BUCKET")


# Static test configuration
if Mix.env == :test do
  import_config "#{Mix.env}.exs"
end
