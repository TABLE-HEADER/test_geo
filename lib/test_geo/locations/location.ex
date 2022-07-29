defmodule TestGeo.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestGeo.Repo

  @type t :: %__MODULE__{
    id: Ecto.UUID.t(),
    lat: float(),
    lng: float(),
    name: String.t()
  }

  schema "locations" do
    field :lat, :float
    field :lng, :float
    field :name, :string
    timestamps()
  end

  def build_changeset(), do: cast(%__MODULE__{}, %{}, [])

  @fields [
    :lat,
    :lng,
    :name
  ]

  def changeset(location, attrs \\ %{}) do
    location
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end

  def create_location(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

end
