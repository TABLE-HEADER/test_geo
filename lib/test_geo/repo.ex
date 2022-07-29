defmodule TestGeo.Repo do
  use Ecto.Repo,
    otp_app: :test_geo,
    adapter: Ecto.Adapters.Postgres
end
