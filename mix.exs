defmodule S3DirectUpload.Mixfile do
  use Mix.Project

  def project do
    [app: :s3_direct_upload,
     version: "0.1.3",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  def application do
    [extra_applications: [:logger]]
  end

  # Dependencies
  defp deps do
    [{:poison, "~> 2.0 or ~> 3.0"},
     {:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp description do
    """
    Pre-signed S3 upload helper for client-side multipart POSTs.
    """
  end

  defp package do
    [
     name: :s3_direct_upload,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Andrew Kappen"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/akappen/s3_direct_upload",
              "S3 Direct Uploads With Ember And Phoenix" => "http://haughtcodeworks.com/blog/software-development/s3-direct-uploads-with-ember-and-phoenix/",
              "Browser-Based Upload using HTTP POST (Using AWS Signature Version 4)" => "http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-post-example.html",
              "Task 3: Calculate the Signature for AWS Signature Version 4" => "http://docs.aws.amazon.com/general/latest/gr/sigv4-calculate-signature.html"}
    ]
  end
end
