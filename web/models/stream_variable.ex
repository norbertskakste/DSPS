defmodule Dsps.StreamVariable do
  use Dsps.Web, :model

  schema "stream_variables" do
    field :name, :string
    field :comment, :string
    timestamps()

    belongs_to :stream, Dsps.Stream, foreign_key: :stream_id
    belongs_to :primitive, Dsps.Stream, foreign_key: :primitive_id
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :comment])
    |> cast_assoc(:stream)
    |> validate_required([:name])
    |> assoc_constraint(:stream)
    |> assoc_constraint(:primitive)
  end
end
