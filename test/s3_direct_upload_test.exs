defmodule S3DirectUploadTest do
  use ExUnit.Case
  doctest S3DirectUpload

  import Map, only: [get: 2]

  test "presigned_json" do
    upload = %S3DirectUpload{
      file_name: "file.jpg",
      mimetype: "image/jpeg",
      path: "path/in/bucket"
    }
    result = S3DirectUpload.presigned_json(upload) |> Poison.decode!
    assert result |> get("url") == "https://s3-bucket.s3.amazonaws.com"
    credentials = result |> get("credentials")
    assert credentials |> get("acl") == "public-read"
    assert credentials |> get("key") == "path/in/bucket/file.jpg"
    assert credentials |> get("policy") |> String.slice(0..9) == "eyJleHBpcm"
    assert credentials |> get("x-amz-algorithm") == "AWS4-HMAC-SHA256"
    assert credentials |> get("x-amz-credential") == "123abc/20170101/us-east-1/s3/aws4_request"
    assert credentials |> get("x-amz-date") == "20170101T000000Z"
    assert credentials |> get("x-amz-signature") == "1c1210287ea2cb1c915ee11b9515b2d811f4b21a90e78a45f12465974ebb95f1"
  end
end
