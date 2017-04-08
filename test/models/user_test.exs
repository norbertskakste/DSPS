defmodule Dsps.UserTest do
    use Dsps.ModelCase

    alias Dsps.User

    @valid_attrs %{email: "test@test.com", username: "testUsername", virtual_password: "testPassword", password: "testPassword"}
    @invalid_email_attrs %{email: "email", username: "testUsername", virtual_password: "testPassword", password: "testPassword" }
    @invalid_attrs%{email: "test@test.com", username: "testUsername"}

    test "changeset with valid attributes" do
        changeset = User.changeset(%User{}, @valid_attrs)
        assert changeset.valid?
    end

    test "changeset with invalid email" do
        changeset = User.changeset(%User{}, @invalid_email_attrs)
        assert !changeset.valid?
    end

    test "changeset with invalid attributes" do
        changeset = User.changeset(%User{}, @invalid_attrs)
        assert !changeset.valid?
    end
end