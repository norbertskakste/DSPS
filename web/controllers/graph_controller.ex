defmodule Dsps.GraphController do
  use Dsps.Web, :controller

  alias Dsps.Graph

  def index(conn, _params) do
    graphs = Repo.all(Graph)
    render(conn, "index.html", graphs: graphs)
  end

  def new(conn, _params) do
    changeset = Graph.changeset(%Graph{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"graph" => graph_params}) do
    changeset = Graph.changeset(%Graph{}, graph_params)

    case Repo.insert(changeset) do
      {:ok, _graph} ->
        conn
        |> put_flash(:info, "Graph created successfully.")
        |> redirect(to: graph_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    graph = Repo.get!(Graph, id)
    |> Repo.preload(:stream)
    |> Repo.preload(:stream_variable)

    render(conn, "show.html", graph: graph)
  end


  def data(conn, %{"graph_id" => id}) do
    graph = Repo.get!(Graph, id)
    |> Repo.preload(:stream)
    |> Repo.preload(:stream_variable)

    IO.inspect(graph.stream_variable.name)

    data = Dsps.Streams.Mongo.get_data_from_stream_id(graph.stream.id)
    |> Enum.map(fn (value) ->
      Map.delete(value, "_id")
    end)
    |> Enum.filter(fn (value) ->
      IO.puts("kek")
      IO.inspect(value)
      Map.has_key?(value, graph.stream_variable.name)
    end)
    |> Enum.map(fn (value) ->
      String.to_integer(value[graph.stream_variable.name])
    end)

    json conn, data
  end

  def edit(conn, %{"id" => id}) do
    graph = Repo.get!(Graph, id)
    changeset = Graph.changeset(graph)
    render(conn, "edit.html", graph: graph, changeset: changeset)
  end

  def update(conn, %{"id" => id, "graph" => graph_params}) do
    graph = Repo.get!(Graph, id)
    changeset = Graph.changeset(graph, graph_params)

    case Repo.update(changeset) do
      {:ok, graph} ->
        conn
        |> put_flash(:info, "Graph updated successfully.")
        |> redirect(to: graph_path(conn, :show, graph))
      {:error, changeset} ->
        render(conn, "edit.html", graph: graph, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    graph = Repo.get!(Graph, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(graph)

    conn
    |> put_flash(:info, "Graph deleted successfully.")
    |> redirect(to: graph_path(conn, :index))
  end
end
