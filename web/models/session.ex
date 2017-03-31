defmodule Dsps.Session do
    import Exredis
    use Timex
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
            nil -> Comeonin.Bcrypt.dummy_checkpw
            _ -> Comeonin.Bcrypt.checkpw(password, user.password)
        end
    end

    def create_session(conn, user = %Dsps.User{}) do
        session_data = Dsps.Redis.Session.UserSession.new_session(user)
        uuid = UUID.uuid1 <> "." <> UUID.uuid4
        Dsps.Redis.Session.new_redis_session(uuid, session_data)
        conn
        |> Plug.Conn.put_session(:user_session, uuid)
    end

    def delete_session(conn) do
        Plug.Conn.get_session(conn, :user_session)
        |> Dsps.Redis.Session.delete_redis_session
        conn
        |> Plug.Conn.delete_session(:user_session)
    end

    def current_user(conn) do
        redis_session = Plug.Conn.get_session(conn, :user_session)
        |> Dsps.Redis.Session.get_redis_session

        user_info = Dsps.Repo.get(User, redis_session.id)
        %{
            session: redis_session,
            user: user_info
        }
    end

    def current_user(conn, :silent) do
        redis_session = Plug.Conn.get_session(conn, :user_session)
        |> Dsps.Redis.Session.get_redis_session(:silent)

        user_info = Dsps.Repo.get(User, redis_session.id)
        %{
            session: redis_session,
            user: user_info
        }
    end

    def logged_in?(conn) do
        uuid = Plug.Conn.get_session(conn, :user_session)
        cond do
            !is_bitstring(uuid) -> false
            true ->
                redis_session = Dsps.Redis.Session.get_redis_session(uuid)
                case redis_session do
                    :undefined -> false
                    _ -> true
                end
        end
    end
end