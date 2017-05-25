defmodule Dsps.StreamGraphController do
  use Dsps.Web, :controller

  alias Dsps.StreamGraph

  def index(conn, _params) do
    stream_graphs = Repo.all(StreamGraph)
    render(conn, "index.html", stream_graphs: stream_graphs)
  end

  def new(conn, _params) do
    changeset = StreamGraph.changeset(%StreamGraph{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stream_graph" => stream_graph_params}) do
    changeset = StreamGraph.changeset(%StreamGraph{}, stream_graph_params)

    case Repo.insert(changeset) do
      {:ok, _stream_graph} ->
        conn
        |> put_flash(:info, "Stream graph created successfully.")
        |> redirect(to: stream_graph_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stream_graph = Repo.get!(StreamGraph, id)
    render(conn, "show.html", stream_graph: stream_graph)
  end

  def edit(conn, %{"id" => id}) do
    stream_graph = Repo.get!(StreamGraph, id)
    changeset = StreamGraph.changeset(stream_graph)
    render(conn, "edit.html", stream_graph: stream_graph, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stream_graph" => stream_graph_params}) do
    stream_graph = Repo.get!(StreamGraph, id)
    changeset = StreamGraph.changeset(stream_graph, stream_graph_params)

    case Repo.update(changeset) do
      {:ok, stream_graph} ->
        conn
        |> put_flash(:info, "Stream graph updated successfully.")
        |> redirect(to: stream_graph_path(conn, :show, stream_graph))
      {:error, changeset} ->
        render(conn, "edit.html", stream_graph: stream_graph, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stream_graph = Repo.get!(StreamGraph, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stream_graph)

    conn
    |> put_flash(:info, "Stream graph deleted successfully.")
    |> redirect(to: stream_graph_path(conn, :index))
  end
end
