defmodule Dsps.PageController do
    use Dsps.Web, :controller
    alias Dsps.Stream

    def index(conn, params) do
    if(conn.assigns.user_data == nil) do
        redirect conn, to: registration_path(conn, :new)
    else
        user_id = conn.assigns.user_data.id

        notes = Dsps.Note.get_all_by_user(user_id, :frontpage)

        streams = Dsps.Note
        |> Repo.all

        {query, streams_paginate} = Stream
        |> Stream.rummage(params["rummage"])

        streams = query
        |> Repo.all

        IO.inspect(streams_paginate)

        stream_page =
                Stream
                |> order_by(desc: :inserted_at)
                |> Repo.paginate(params)

        render conn, "index.html", notes: notes, streams: streams, streams_paginate: streams_paginate
        end
    end
end
