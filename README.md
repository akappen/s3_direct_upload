# S3DirectUpload

Pre-signed S3 upload helper for client-side multipart POSTs in Elixir.

See: [Browser Uploads to S3 using HTML POST Forms](https://aws.amazon.com/articles/1434/)

## Installation

S3DirectUpload can be installed by adding `s3_direct_upload` to your
list of dependencies in `mix.exs` and then running `mix deps.get`:

```elixir
def deps do
  [{:s3_direct_upload, "~> 0.1.0"}]
end
```

This module expects three application configuration settings for the
AWS access and secret keys and the S3 bucket name. Here is an
example configuration that reads these from environment
variables. Add your own configuration to `config.exs`.

```elixir
config :s3_direct_upload,
  aws_access_key: System.get_env("AWS_ACCESS_KEY_ID"),
  aws_secret_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  aws_s3_bucket: System.get_env("AWS_S3_BUCKET")

```

## Documentation

[S3DirectUpload docs](https://hexdocs.pm/s3_direct_upload).
