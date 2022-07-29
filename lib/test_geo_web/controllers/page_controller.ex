defmodule TestGeoWeb.PageController do
  use TestGeoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
