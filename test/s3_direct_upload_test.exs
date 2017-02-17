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
    assert credentials |> get("AWSAccessKeyId") == "123abc"
    assert credentials |> get("signature") == "2XVAeyDzZTVI6XCSGZnoMUab2lI="
    assert credentials |> get("policy") |> String.slice(0..9) == "eyJleHBpcm"
    assert credentials |> get("acl") == "public-read"
    assert credentials |> get("key") == "path/in/bucket/file.jpg"
  end
end
