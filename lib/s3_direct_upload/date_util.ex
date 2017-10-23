defmodule S3DirectUpload.DateUtil do

  @moduledoc false

  def today_datetime do
    %{DateTime.utc_now | hour: 0, minute: 0, second: 0, microsecond: {0,0}}
    |> DateTime.to_iso8601(:basic)
  end

  def today_date do
    Date.utc_today
    |> Date.to_iso8601(:basic)
  end

  def expiration_datetime do
    DateTime.utc_now()
    |> DateTime.to_unix()
    |> Kernel.+(60 * 60)
    |> DateTime.from_unix!()
    |> DateTime.to_iso8601()
  end
end
