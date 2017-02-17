defmodule S3DirectUpload.Mixfile do
  use Mix.Project

  def project do
    [app: :s3_direct_upload,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies
  defp deps do
    [{:poison, "~> 3.0"},
     {:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp description do
    """
    Pre-signed S3 upload helper for client-side multipart POSTs.

    See: [Browser Uploads to S3 using HTML POST Forms](https://aws.amazon.com/articles/1434/)
    """
  end

  defp package do
    [
     name: :s3_direct_upload,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Andrew Kappen"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/akappen/s3_direct_upload",
              "Docs" => "https://hexdocs.pm/s3_direct_upload"}
    ]
  end
end
