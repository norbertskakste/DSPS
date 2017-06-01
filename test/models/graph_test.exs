defmodule Dsps.GraphTest do
  use Dsps.ModelCase

  alias Dsps.Graph

  @valid_attrs %{name: "some content", stream_id: 42, stream_variable_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Graph.changeset(%Graph{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Graph.changeset(%Graph{}, @invalid_attrs)
    refute changeset.valid?
  end
end
