defmodule Dsps.StreamController do
    use Dsps.Web, :controller
    use Rummage.Ecto
    use Rummage.Phoenix.Controller
    import UUID
    import Elibuf

    alias Dsps.Stream

    def index(conn, params) do
        page =
        Stream
        |> order_by(desc: :inserted_at)
        |> Repo.paginate(params)

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
      |> Repo.preload(:stream_variables)
      stream_variable_changeset = Dsps.StreamVariable.changeset(%Dsps.StreamVariable{})

      render(conn, "show.html", stream: stream, stream_variable_changeset: stream_variable_changeset)
    end

    def finalize(conn, %{"stream_id" => id}) do
        stream = Repo.get!(Dsps.Stream, id)
        changeset = Stream.changeset(stream, %{finalized: true})

        case Repo.update(changeset) do
            {:ok, _} ->
                conn
                |> put_flash(:info, "Stream finalized successfully.")
                |> redirect(to: stream_path(conn, :show, stream))
            {:error, changeset} ->
                conn
                |> put_flash(:info, "Couldn't finalize stream.")
                |> redirect(to: stream_path(conn, :show, stream))
        end
    end

    def create(conn, %{"stream" => stream_params}) do
      changeset = Stream.changeset(%Stream{realtime: true, enabled: true, uuid: UUID.uuid1()}, stream_params)

      case Repo.insert(changeset) do
        {:ok, _stream} ->
            conn
            |> put_flash(:info, "Stream created succesfully.")
            |> redirect(to: stream_path(conn, :index))
        {:error, changeset} ->
            render(conn, "new.html", changeset: changeset)
      end
    end

    def delete(conn, %{"id" => id}) do
        stream = Repo.get!(Dsps.Stream, id)
        Repo.delete!(stream)

        conn
        |> put_flash(:info, "Stream deleted successfully.")
        |> redirect(to: stream_path(conn, :index))
      end


    def all_info(conn, %{"stream_id" => id}) do
        stream = Repo.get!(Dsps.Stream, id)

        json conn, %{
            id: stream.id,
            name: stream.name,
            description: stream.description,
            finalized: stream.finalized,
            uuid: stream.uuid
        }
    end

    def generate(conn, %{"stream_id" => id}) do

    end
end