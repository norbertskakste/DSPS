defmodule Dsps.Session do
    alias Dsps.User

    def login(params, repo) do
        user = repo.get_by(User, username: params["username"])
        case authenticate(user, params["password"]) do
            true -> {:ok, user}
            _ ->    :error
        end
    end

    defp authenticate(user, password) do
        case user do
            nil -> false
            _ -> Comeonin.Bcrypt.checkpw(password, user.password)
        end
    end

    def get_user_from_session(sessionID) do
        
    end

    def current_user(conn) do

    end

    def logged_in?(conn), do: !!current_user(conn)

    def set_user(user) do
        
    end
end