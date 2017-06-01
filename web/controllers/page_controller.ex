defmodule Dsps.PageController do
    use Dsps.Web, :controller
    alias Dsps.Stream

    def index(conn, params) do
    IO.puts("GETTING DATA")
    IO.puts("GETTING DATA")
    Dsps.Streams.Mongo.get_data_from_stream_id(1)
    |> IO.inspect
    IO.puts("GETTING DATA")
    IO.puts("GETTING DATA")

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
