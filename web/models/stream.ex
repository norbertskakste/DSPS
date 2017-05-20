defmodule Dsps.Stream do
  use Dsps.Web, :model
  use Rummage.Ecto

  schema "streams" do
    field :name, :string
    field :description, :string
    field :realtime, :boolean
    field :enabled, :boolean
    timestamps()

    has_many :stream_variables, Dsps.StreamVariable
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :realtime, :enabled])
    |> validate_required([:name, :description])
    |> unique_constraint(:name, message: "Stream Name already taken")
  end
end
