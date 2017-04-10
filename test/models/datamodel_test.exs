defmodule Dsps.DatamodelTest do
  use Dsps.ModelCase

  alias Dsps.Datamodel

  @valid_attrs %{description: "some content", name: "some content", primitive: true, struct: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Datamodel.changeset(%Datamodel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Datamodel.changeset(%Datamodel{}, @invalid_attrs)
    refute changeset.valid?
  end
end
