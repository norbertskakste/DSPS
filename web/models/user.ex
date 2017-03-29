defmodule Dsps.User do
  use Dsps.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string
    field :virtual_password, :string, virtual: true
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :username, :virtual_password])
    |> validate_required([:email, :username, :virtual_password])
    |> unique_constraint(:email, message: "Email already taken")
    |> validate_format(:email, ~r/@/, message: "Invalid email")
    |> unique_constraint(:username, message: "Username already taken")
  end
end
