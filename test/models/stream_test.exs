defmodule Dsps.StreamTest do
  use Dsps.ModelCase

  alias Dsps.Stream

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stream.changeset(%Stream{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stream.changeset(%Stream{}, @invalid_attrs)
    refute changeset.valid?
  end
end
