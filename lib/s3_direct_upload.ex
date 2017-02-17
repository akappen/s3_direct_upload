defmodule S3DirectUpload do
  @moduledoc """

  Pre-signed S3 upload helper for client-side multipart POSTs.

  See: [Browser Uploads to S3 using HTML POST Forms](https://aws.amazon.com/articles/1434/)

  This module expects three application configuration settings for the
  AWS access and secret keys and the S3 bucket name. Here is an
  example configuration that reads these from environment
  variables. Add your own configuration to `config.exs`.

  ```
  config :s3_direct_upload,
    aws_access_key: System.get_env("AWS_ACCESS_KEY_ID"),
    aws_secret_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
    aws_s3_bucket: System.get_env("AWS_S3_BUCKET")

  ```

  """

  @doc """

  The `S3DirectUpload` struct represents the data necessary to
  generate an S3 pre-signed upload object.

  The required fields are:

  - `file_name` the name of the file being uploaded
  - `mimetype` the mimetype of the file being uploaded
  - `path` the path where the file will be uploaded in the bucket

  Fields that can be over-ridden are:

  - `acl` defaults to `public-read`
  - `access_key` the AWS access key, defaults to application settings
  - `secret_key` the AWS secret key, defaults to application settings
  - `bucket` the S3 bucket, defaults to application settings

  """
  defstruct file_name: nil, mimetype: nil, path: nil,
    acl: "public-read",
    access_key: Application.get_env(:s3_direct_upload, :aws_access_key),
    secret_key: Application.get_env(:s3_direct_upload, :aws_secret_key),
    bucket: Application.get_env(:s3_direct_upload, :aws_s3_bucket)

  @expiration Application.get_env(:s3_direct_upload, :expiration_api, S3DirectUpload.Expiration)

  @doc """

  Returns a map with `url` and `credentials` keys.

  - `url` - the form action URL
  - `credentials` - name/value pairs for hidden input fields

  ## Examples

      iex> %S3DirectUpload{file_name: "image.jpg", mimetype: "image/jpeg", path: "path/to/file"}
      ...> |> S3DirectUpload.presigned
      ...> |> Map.get(:url)
      "https://s3-bucket.s3.amazonaws.com"

      iex> %S3DirectUpload{file_name: "image.jpg", mimetype: "image/jpeg", path: "path/to/file"}
      ...> |> S3DirectUpload.presigned
      ...> |> Map.get(:credentials) |> Map.get(:AWSAccessKeyId)
      "123abc"

      iex> %S3DirectUpload{file_name: "image.jpg", mimetype: "image/jpeg", path: "path/to/file"}
      ...> |> S3DirectUpload.presigned
      ...> |> Map.get(:credentials) |> Map.get(:key)
      "path/to/file/image.jpg"

  """
  def presigned(%S3DirectUpload{} = upload) do
    %{
      url: "https://#{upload.bucket}.s3.amazonaws.com",
      credentials: %{
        AWSAccessKeyId: upload.access_key,
        signature: signature(upload),
        policy: policy(upload),
        acl: upload.acl,
        key: "#{upload.path}/#{upload.file_name}"
      }
    }
  end

  @doc """

  Returns a json object with `url` and `credentials` properties.

  - `url` - the form action URL
  - `credentials` - name/value pairs for hidden input fields

  """
  def presigned_json(%S3DirectUpload{} = upload) do
    presigned(upload)
    |> Poison.encode!
  end

  defp signature(upload) do
    :crypto.hmac(:sha, upload.secret_key, policy(upload))
    |> Base.encode64
  end

  defp policy(upload) do
    %{
      expiration: @expiration.datetime,
      conditions: conditions(upload)
    }
    |> Poison.encode!
    |> Base.encode64
  end

  defp conditions(upload) do
    [
      %{"bucket" => upload.bucket},
      %{"acl" => upload.acl},
      ["starts-with", "$Content-Type", upload.mimetype],
      ["starts-with", "$key", upload.path]
    ]
  end
end
