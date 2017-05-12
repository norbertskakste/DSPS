defmodule Dsps.Primitive do
  use Dsps.Web, :model

  schema "primitives" do
    field :name, :string
    field :description, :string
    field :max_value, :integer
    field :min_value, :integer
    field :max_length, :integer
    field :min_length, :integer
    timestamps()

    has_many :stream_variables, Dsps.StreamVariable
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :max_value, :min_value, :max_length, :min_length])
    |> validate_required([:name, :description])
    |> unique_constraint(:name, message: "Type name already taken")
  end
end