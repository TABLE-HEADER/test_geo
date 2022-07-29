defmodule TestGeo.Repo.Migrations.Locations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :lat, :float, null: false
      add :lng, :float, null: false
      add :name, :string, null: false
      timestamps()
    end
  end
end
