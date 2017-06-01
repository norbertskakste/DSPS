defmodule Dsps.GraphView do
  use Dsps.Web, :view

    def get_all_streams() do
    Dsps.Repo.all(Dsps.Stream)
    |> Enum.map(fn (stream) ->
      {:"#{stream.name}", stream.id}
    end)

  end
  
  def get_all_stream_variables(graph) do
      data = Dsps.Repo.get(Dsps.Stream, graph.stream_id)
      |> Dsps.Repo.preload(:stream_variables)

      IO.inspect(data)

      data.stream_variables
        |> Enum.map(fn (variable) ->
        {:"#{variable.name}", variable.id}
        end)
    end
end