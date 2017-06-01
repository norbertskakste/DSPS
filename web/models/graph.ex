defmodule Dsps.Graph do
  use Dsps.Web, :model

  schema "graphs" do
    field :name, :string

    belongs_to :stream, Dsps.Stream, foreign_key: :stream_id
    belongs_to :stream_variable, Dsps.StreamVariable, foreign_key: :stream_variable_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :stream_id, :stream_variable_id])
    |> validate_required([:name, :stream_id])
  end
end
