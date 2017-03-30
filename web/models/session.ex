defmodule Dsps.Session do
    import Exredis
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
            :poolboy.checkin(:redis_pool, pid)
            if id do
                Dsps.Repo.get(User, id)
            end
        end
    end

    def logged_in_time(conn) do
        pid = :poolboy.checkout(:redis_pool)
        sessionID = Plug.Conn.get_session(conn, :current_user)
        if sessionID do
            logged_in = Exredis.Api.hget(pid, sessionID, "logged_in")
            :poolboy.checkin(:redis_pool, pid)
            logged_in
        end
    end

    def action(conn) do
        pid = :poolboy.checkout(:redis_pool)
        sessionID = Plug.Conn.get_session(conn, :current_user)
        if sessionID do
            logged_in = Exredis.Api.hset(pid, sessionID, "last_action", DateTime.utc_now |> DateTime.to_string)
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

        Exredis.query(pid, ["MULTI"])
        Exredis.query(pid, ["HSET", uuid, "id", user.id])
        Exredis.query(pid, ["HSET", uuid, "logged_in", DateTime.utc_now |> DateTime.to_string])
        Exredis.query(pid, ["HSET", uuid, "last_action", DateTime.utc_now |> DateTime.to_string])
        Exredis.query(pid, ["EXEC"])

        :poolboy.checkin(:redis_pool, pid)
        conn
    end
end