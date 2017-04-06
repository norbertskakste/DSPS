defmodule Dsps.UserTest do
  use Dsps.ModelCase

  alias Dsps.User

  @valid_attrs %{email: "email@email.com", password: "securePassword", username: "niceUsername", virtual_password: "niceVirtualPassword"}
  @invalid_attrs %{email "asdfsafadsf", password: "securePassword", username: "niceUsername"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
