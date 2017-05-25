defmodule Dsps.StreamVariableController do
    use Dsps.Web, :controller

    alias Dsps.Stream
    alias Dsps.StreamVariable
    alias Dsps.Primitive

    def create(conn, %{"stream_variable" => stream_variable_params, "stream_id" => stream_id}) do
        stream = Repo.get(Stream, stream_id)

        if stream.finalized do
          conn
          |> put_flash(:info, "Stream already finalized")
          |> redirect(to: stream_path(conn, :show, stream))
        else
            primitive = Repo.get(Primitive, stream_variable_params["primitive_id"])

            changeset = StreamVariable.changeset(%StreamVariable{stream_id: stream.id, primitive_id: primitive.id}, stream_variable_params)

            case Repo.insert(changeset) do
                {:ok, _} ->
                    conn
                    |> put_flash(:info, "Stream variable created succesfully.")
                    |> redirect(to: stream_path(conn, :show, stream))
                {:error, changeset} ->
                    render(conn, "new.html", changeset: changeset)
            end
        end
      end
end