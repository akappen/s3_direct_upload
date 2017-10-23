# S3DirectUpload

Pre-signed S3 upload helper for client-side multipart POSTs in Elixir.

See:
[Browser-Based Upload using HTTP POST (Using AWS Signature Version 4)](http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-post-example.html)

[Task 3: Calculate the Signature for AWS Signature Version 4](http://docs.aws.amazon.com/general/latest/gr/sigv4-calculate-signature.html)

## Installation

S3DirectUpload can be installed by adding `s3_direct_upload` to your
list of dependencies in `mix.exs` and then running `mix deps.get`:

```elixir
def deps do
  [{:s3_direct_upload, "~> 0.1.0"}]
end
```

This module expects three application configuration settings for the
AWS access and secret keys and the S3 bucket name. You may also supply
an AWS region (the default if you do not is `us-east-1`). Here is an
example configuration that reads these from environment variables. Add
your own configuration to `config.exs`.

```elixir
config :s3_direct_upload,
  aws_access_key: System.get_env("AWS_ACCESS_KEY_ID"),
  aws_secret_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  aws_s3_bucket: System.get_env("AWS_S3_BUCKET"),
  aws_region: System.get_env("AWS_REGION")

```

## Documentation

[S3DirectUpload docs](https://hexdocs.pm/s3_direct_upload).
