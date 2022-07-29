defmodule TestGeoWeb.MapController do
  use TestGeoWeb, :controller
  import Plug.Conn
  alias TestGeo.Locations.Location
  alias TestGeo.Repo

  def index(conn, _params) do
    locations = Repo.all(Location)
    location = if length(locations) > 0, do: hd(locations), else: %Location{lat: 35.6585802, lng: 139.7366996, name: "東京タワー"}
    render(conn, "index.html", locations: locations, location: location)
  end

  def new(conn, _params) do
    render(conn, "new.html", location: Location.build_changeset())
  end

  def create(conn, %{"location" => location}) do
    case Location.create_location(location) do
      {:error, _} ->
        conn
        |> put_flash(:info, "入力に誤りがあります。")
        |> redirect(to: Routes.map_path(conn, :new))
      _ ->
        conn
        |> put_flash(:info, "登録が完了しました。")
        |> redirect(to: Routes.map_path(conn, :index))
    end
  end

  def detail(conn, %{"id" => id}) do
    case location = Repo.get(Location, id) do
      {:error, _} ->
        conn
        |> put_flash(:info, "詳細情報の取得に失敗しました。")
        |> redirect(to: Routes.map_path(conn, :index))
      _ ->
        conn
        |> render("detail.html", location: Location.changeset(location))
    end
  end

  def edit(conn, %{"id" => id}) do
    case location = Repo.get(Location, id) do
      {:error, _} ->
        conn
        |> put_flash(:info, "詳細情報の取得に失敗しました。")
        |> redirect(to: Routes.map_path(conn, :index))
      _ ->
        conn
        |> render("edit.html", location: location)
    end
  end

  def delete(conn, %{"id" => id}) do
    case location = Repo.get(Location, id) do
      {:error, _} ->
        conn
        |> put_flash(:info, "削除に失敗しました。")
        |> redirect(to: Routes.map_path(conn, :index))
      _ ->
        Repo.delete(location)
        conn
        |> put_flash(:info, "削除しました。")
        |> redirect(to: Routes.map_path(conn, :index))
    end
  end
end
