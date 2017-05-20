defmodule Dsps.StreamVariableTest do
  use Dsps.ModelCase

  alias Dsps.StreamVariable

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = StreamVariable.changeset(%StreamVariable{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = StreamVariable.changeset(%StreamVariable{}, @invalid_attrs)
    refute changeset.valid?
  end
end
