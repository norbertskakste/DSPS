defmodule Dsps.GraphControllerTest do
  use Dsps.ConnCase

  alias Dsps.Graph
  @valid_attrs %{name: "some content", stream_id: 42, stream_variable_id: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, graph_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing graphs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, graph_path(conn, :new)
    assert html_response(conn, 200) =~ "New graph"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, graph_path(conn, :create), graph: @valid_attrs
    assert redirected_to(conn) == graph_path(conn, :index)
    assert Repo.get_by(Graph, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, graph_path(conn, :create), graph: @invalid_attrs
    assert html_response(conn, 200) =~ "New graph"
  end

  test "shows chosen resource", %{conn: conn} do
    graph = Repo.insert! %Graph{}
    conn = get conn, graph_path(conn, :show, graph)
    assert html_response(conn, 200) =~ "Show graph"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, graph_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    graph = Repo.insert! %Graph{}
    conn = get conn, graph_path(conn, :edit, graph)
    assert html_response(conn, 200) =~ "Edit graph"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    graph = Repo.insert! %Graph{}
    conn = put conn, graph_path(conn, :update, graph), graph: @valid_attrs
    assert redirected_to(conn) == graph_path(conn, :show, graph)
    assert Repo.get_by(Graph, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    graph = Repo.insert! %Graph{}
    conn = put conn, graph_path(conn, :update, graph), graph: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit graph"
  end

  test "deletes chosen resource", %{conn: conn} do
    graph = Repo.insert! %Graph{}
    conn = delete conn, graph_path(conn, :delete, graph)
    assert redirected_to(conn) == graph_path(conn, :index)
    refute Repo.get(Graph, graph.id)
  end
end
