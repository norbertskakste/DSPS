defmodule Dsps.StreamController do
    use Dsps.Web, :controller
    use Rummage.Ecto
    use Rummage.Phoenix.Controller

    alias Dsps.Stream

    def index(conn, params) do
        page =
        Stream
        |> order_by(desc: :inserted_at)
        |> Repo.paginate(params)

        streams = Stream
        |> Repo.all

        {query, rummage} = Stream
        |> Stream.rummage(params["rummage"])

        streams = query
        |> Repo.all

        conn
        |> Scrivener.Headers.paginate(page)
        |> render  :index,
                   streams: streams,
                   rummage: rummage
    end

    def new(conn, _params) do
      changeset = Stream.changeset(%Stream{})

      render(conn, "new.html", changeset: changeset)
    end

    def show(conn, %{"id" => id}) do
      stream = Repo.get!(Stream, id)
      render(conn, "show.html", stream: stream)
    end

    def create(conn, %{"stream" => stream_params}) do
      changeset = Stream.changeset(%Stream{realtime: true, enabled: true}, stream_params)

      case Repo.insert(changeset) do
        {:ok, _stream} ->
            conn
            |> put_flash(:info, "Stream created succesfully.")
            |> redirect(to: stream_path(conn, :index))
        {:error, changeset} ->
            render(conn, "new.html", changeset: changeset)
      end
    end
end