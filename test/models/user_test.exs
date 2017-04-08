defmodule Dsps.UserTest do
    use Dsps.ModelCase

    alias Dsps.User

    @valid_attrs %{email: "test@test.com", username: "testUsername", virtual_password: "testPassword", password: "testPassword"}

    test "changeset with valid attributes" do
        changeset = User.changeset(%User{}, @valid_attrs)
        assert changeset.valid?
    end
end