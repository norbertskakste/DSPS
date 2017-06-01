defmodule Dsps.TableTest do
  use Dsps.ModelCase

  alias Dsps.Table

  @valid_attrs %{name: "some content", stream_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Table.changeset(%Table{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Table.changeset(%Table{}, @invalid_attrs)
    refute changeset.valid?
  end
end
