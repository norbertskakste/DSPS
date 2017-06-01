defmodule Dsps.Streams.Mongo do

    import Mongo

    def get_data_from_stream_id(id) do
        {:ok, mongo_pid} = Mongo.start_link(database: "dsps")
        data = mongo_pid
        |> Mongo.find("stream_data_" <> Integer.to_string(id), %{})
        |> Enum.to_list
        |> Enum.reverse
        |> Enum.take(100)

        Process.exit(mongo_pid, :normal)

        data
    end

    def get_data_from_stream_id(id, limit) when is_integer(limit) do
        {:ok, mongo_pid} = Mongo.start_link(database: "dsps")
        data = mongo_pid
        |> Mongo.find("stream_data_" <> Integer.to_string(id), %{})
        |> Enum.to_list
        |> Enum.reverse
        |> Enum.take(limit)

        Process.exit(mongo_pid, :normal)

        data
    end
end