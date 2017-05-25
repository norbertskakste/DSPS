defmodule Dsps.StreamView do
    use Dsps.Web, :view

    import Scrivener.HTML
    use Rummage.Phoenix.View

    alias Dsps.Repo
    alias Dsps.Primitive

    def get_primitive(id) when is_integer(id) do
        Repo.get(Primitive, id)
    end

end