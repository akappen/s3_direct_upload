defmodule S3DirectUpload.StaticDateUtil do

  @moduledoc false

  def today_datetime do
    static_datetime()
    |> DateTime.to_iso8601(:basic)
  end

  def today_date do
    static_date()
    |> Date.to_iso8601(:basic)
  end

  def expiration_datetime do
    static_datetime()
    |> DateTime.to_unix()
    |> Kernel.+(60 * 60)
    |> DateTime.from_unix!()
    |> DateTime.to_iso8601()
  end

  defp static_datetime do
    ~N[2017-01-01 00:00:00]
    |> DateTime.from_naive!("Etc/UTC")
  end

  defp static_date do
    ~D[2017-01-01]
  end
end
