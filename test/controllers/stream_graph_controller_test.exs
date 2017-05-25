defmodule Dsps.StreamGraphControllerTest do
  use Dsps.ConnCase

  alias Dsps.StreamGraph
  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stream_graph_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing stream graphs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, stream_graph_path(conn, :new)
    assert html_response(conn, 200) =~ "New stream graph"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, stream_graph_path(conn, :create), stream_graph: @valid_attrs
    assert redirected_to(conn) == stream_graph_path(conn, :index)
    assert Repo.get_by(StreamGraph, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stream_graph_path(conn, :create), stream_graph: @invalid_attrs
    assert html_response(conn, 200) =~ "New stream graph"
  end

  test "shows chosen resource", %{conn: conn} do
    stream_graph = Repo.insert! %StreamGraph{}
    conn = get conn, stream_graph_path(conn, :show, stream_graph)
    assert html_response(conn, 200) =~ "Show stream graph"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, stream_graph_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    stream_graph = Repo.insert! %StreamGraph{}
    conn = get conn, stream_graph_path(conn, :edit, stream_graph)
    assert html_response(conn, 200) =~ "Edit stream graph"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    stream_graph = Repo.insert! %StreamGraph{}
    conn = put conn, stream_graph_path(conn, :update, stream_graph), stream_graph: @valid_attrs
    assert redirected_to(conn) == stream_graph_path(conn, :show, stream_graph)
    assert Repo.get_by(StreamGraph, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    stream_graph = Repo.insert! %StreamGraph{}
    conn = put conn, stream_graph_path(conn, :update, stream_graph), stream_graph: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit stream graph"
  end

  test "deletes chosen resource", %{conn: conn} do
    stream_graph = Repo.insert! %StreamGraph{}
    conn = delete conn, stream_graph_path(conn, :delete, stream_graph)
    assert redirected_to(conn) == stream_graph_path(conn, :index)
    refute Repo.get(StreamGraph, stream_graph.id)
  end
end
