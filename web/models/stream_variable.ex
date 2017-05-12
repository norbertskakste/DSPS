defmodule Dsps.StreamVariable do
  use Dsps.Web, :model

  schema "stream_variables" do
    field :name, :string
    field :comment, :string
    timestamps()

    has_many :primitives, Dsps.Primitive
    has_one :streams, Dsps.Stream
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :comment])
    |> validate_required([:name])
  end
end
