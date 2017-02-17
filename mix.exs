defmodule S3DirectUpload.Mixfile do
  use Mix.Project

  def project do
    [app: :s3_direct_upload,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
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
end
