defmodule Dsps.Repo do
  use Ecto.Repo, otp_app: :dsps
  use Scrivener, page_size: 10
end