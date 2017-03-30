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
            nil -> false
            _ -> Comeonin.Bcrypt.checkpw(password, user.password)
        end
    end

    def get_user_from_session(sessionID) do
        if sessionID do
            id = Exredis.Api.get(sessionID)
            if id do
                Dsps.Repo.get(User, id)
            end
        end
    end

    def current_user(conn) do
        pid = :poolboy.checkout(:redis_pool)
        sessionID = Plug.Conn.get_session(conn, :current_user)
        if sessionID do
            id = Exredis.Api.hget(pid, sessionID, "id")
            logged_in = Exredis.Api.hget(pid, sessionID, "logged_in")
            last_action = Exredis.Api.hget(pid, sessionID, "last_action")
            :poolboy.checkin(:redis_pool, pid)
            case id do
                :undefined ->
                    false
                _ ->
                    action(conn)
                    user = Dsps.Repo.get(User, id)
                    %{
                        user: user,
                        session: %{
                            id: id,
                            logged_in: logged_in,
                            last_action: last_action
                        }
                    }
            end

        end
    end

    def action(conn) do
        pid = :poolboy.checkout(:redis_pool)
        sessionID = Plug.Conn.get_session(conn, :current_user)
        if sessionID do
            time_now = Timex.now
            |> Timex.format!("%FT%T%:z", :strftime)
            Exredis.query(pid, ["MULTI"])
            Exredis.query(pid, ["HSET", sessionID, "last_action", time_now])
            Exredis.query(pid, ["EXPIRE", sessionID, 60])
            Exredis.query(pid, ["EXEC"])
            Exredis.Api.hset(pid, sessionID, "last_action", time_now)
            :poolboy.checkin(:redis_pool, pid)
        end
    end

    def last_action(conn) do
        pid = :poolboy.checkout(:redis_pool)
        sessionID = Plug.Conn.get_session(conn, :current_user)
        if sessionID do
            logged_in = Exredis.Api.hget(pid, sessionID, "last_action")
            :poolboy.checkin(:redis_pool, pid)
            logged_in
        end
    end

    def logged_in?(conn), do: !!current_user(conn)

    def set_user(conn, uuid, user) do
        pid = :poolboy.checkout(:redis_pool)
        time_now = Timex.now
        |> Timex.format!("%FT%T%:z", :strftime)

        Exredis.query(pid, ["MULTI"])
        Exredis.query(pid, ["HSET", uuid, "id", user.id])
        Exredis.query(pid, ["HSET", uuid, "logged_in", time_now])
        Exredis.query(pid, ["HSET", uuid, "last_action", time_now])
        Exredis.query(pid, ["RPUSH", "user_sessions", uuid])
        Exredis.query(pid, ["EXPIRE", uuid, 60])
        Exredis.query(pid, ["EXEC"])

        :poolboy.checkin(:redis_pool, pid)
        conn
    end

    def cleanup() do
        pid = :poolboy.checkout(:redis_pool)
        tokens = Exredis.query(pid, ["LRANGE", "user_sessions", 0, -1])
        :poolboy.checkin(:redis_pool, pid)
        case tokens do
            :undefined -> false
            _ ->
                Enum.map(tokens, fn(token) ->
                    pid = :poolboy.checkout(:redis_pool)
                    last_action = Exredis.query(pid, ["HGET", token, "id"])
                    case last_action do
                        :undefined ->
                            new_pid = :poolboy.checkout(:redis_pool)
                            Exredis.query(pid, ["LREM", "user_sessions", 0, token])
                            IO.puts(token)
                            :poolboy.checkin(:redis_pool, new_pid)
                        _ ->
                            IO.puts(last_action)
                    end
                    :poolboy.checkin(:redis_pool, pid)
                    end)

        end
    end
end