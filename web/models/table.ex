defmodule Dsps.Table do
  use Dsps.Web, :model

  schema "tables" do
    field :name, :string

    belongs_to :stream, Dsps.Stream, foreign_key: :stream_id
    field :stream_variable_ids, {:array, :integer}
    
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :stream_id])
    |> validate_required([:name, :stream_id])
  end
end
