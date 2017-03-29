defmodule Dsps.Registration do
    import Ecto.Changeset

    def create(changeset, repo) do
        changeset
        |> hash_password
        |> repo.insert()
    end

    defp hash_password(struct) do
        password = get_field(struct, :virtual_password)
        cond do
        is_bitstring(password) ->
            struct
            |> put_change(:password, Comeonin.Bcrypt.hashpwsalt(password))
        true ->
            struct
        end
    end
end