defmodule Dsps.Datamodel do
  use Dsps.Web, :model

  schema "datamodels" do
    field :name, :string
    field :description, :string
    field :primitive, :boolean, default: false
    field :struct, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :primitive, :struct])
    |> validate_required([:name, :description, :primitive, :struct])
  end
end
