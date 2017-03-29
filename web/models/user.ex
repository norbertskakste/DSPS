defmodule Dsps.User do
  use Dsps.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
