defmodule Dsps.UserTest do
  use Dsps.ModelCase

  alias Dsps.User

  @valid_attrs %{email: "email@email.com", password: "securePassword", username: "niceUsername"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
