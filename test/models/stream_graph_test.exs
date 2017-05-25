defmodule Dsps.StreamGraphTest do
  use Dsps.ModelCase

  alias Dsps.StreamGraph

  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = StreamGraph.changeset(%StreamGraph{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = StreamGraph.changeset(%StreamGraph{}, @invalid_attrs)
    refute changeset.valid?
  end
end
