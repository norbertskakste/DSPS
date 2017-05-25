defmodule Dsps.StreamVariableView do
    use Dsps.Web, :view

    alias Dsps.Repo
    alias Dsps.Primitive

    def get_primitives() do
        Repo.all(Primitive)
        |> Enum.map(fn (primitive) ->
            {:"#{primitive.name}", primitive.id}
         end)
    end
end