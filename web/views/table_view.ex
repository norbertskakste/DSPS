defmodule Dsps.TableView do
  use Dsps.Web, :view

  def get_all_streams() do
    Dsps.Repo.all(Dsps.Stream)
    |> Enum.map(fn (stream) ->
      {:"#{stream.name}", stream.id}
    end)
  end

  def get_table_data(table) do
    IO.puts(table.stream.id)

    data = Dsps.Streams.Mongo.get_data_from_stream_id(table.stream.id, 20)
    IO.inspect(data)

    data
  end

  def get_table_fields(table) do
    Dsps.Streams.Mongo.get_data_from_stream_id(table.stream_id, 20)
    |> Enum.map(fn (data) -> 
      Map.delete(data, "_id")
    end)
    |> Enum.map(fn (data) ->
      Enum.map(data, fn (value) -> elem(value, 0) end)
    end)
    |> List.flatten
    |> Enum.uniq
  end

  def get_specific_table_fields(table) do
    stream_data = Dsps.Repo.get(Dsps.Stream, table.stream_id)
    |> Dsps.Repo.preload(:stream_variables)

    IO.inspect(stream_data)

    stream_data.stream_variables
  end
end
