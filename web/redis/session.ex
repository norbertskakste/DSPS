defmodule Dsps.Redis.Session do

    defmodule UserSession do
        use Timex

        defstruct id: nil, logged_in: nil, last_action: nil

        def new_session(user = %Dsps.User{}) do
            time_now = Timex.now |> Timex.format!("%FT%T%:z", :strftime)
            %__MODULE__{id: user.id, logged_in: time_now, last_action: time_now}
        end

        def new_session(id) when is_integer(id) do
            time_now = Timex.now |> Timex.format!("%FT%T%:z", :strftime)
            %__MODULE__{id: id, logged_in: time_now, last_action: time_now}
        end

        def new_session(id, logged_in, last_action) do
            %__MODULE__{id: id, logged_in: logged_in, last_action: last_action}
        end
    end

    def new_redis_session(uuid, user_session = %UserSession{}) do
        :poolboy.transaction(:redis_pool, fn worker ->
            Exredis.query(worker, ["MULTI"])
            Exredis.query(worker, ["HSET", uuid, "id", user_session.id])
            Exredis.query(worker, ["HSET", uuid, "logged_in", user_session.logged_in])
            Exredis.query(worker, ["HSET", uuid, "last_action", user_session.last_action])
            Exredis.query(worker, ["RPUSH", "user_sessions", uuid])
            Exredis.query(worker, ["EXPIRE", uuid, 60])
            Exredis.query(worker, ["EXEC"])
        end)
    end

    def session_extend(uuid) do
        :poolboy.transaction(:redis_pool, fn worker ->
            time_now = Timex.now |> Timex.format!("%FT%T%:z", :strftime)
            Exredis.query(worker, ["EXPIRE", uuid, 60])
            Exredis.query(worker, ["HSET", uuid, "last_action", time_now])
        end)
    end

    def get_redis_session(uuid) do
        :poolboy.transaction(:redis_pool, fn worker ->
            id = Exredis.query(worker, ["HGET", uuid, "id"])
            logged_in = Exredis.query(worker, ["HGET", uuid, "logged_in"])
            last_action = Exredis.query(worker, ["HGET", uuid, "last_action"])
            Exredis.query(worker, ["EXPIRE", uuid, 60])
            case id do
                :undefined -> :undefined
                _ -> UserSession.new_session(id, logged_in, last_action)
            end
        end)
    end

    def get_redis_session(uuid, :silent) do
        :poolboy.transaction(:redis_pool, fn worker ->
            id = Exredis.query(worker, ["HGET", uuid, "id"])
            logged_in = Exredis.query(worker, ["HGET", uuid, "logged_in"])
            last_action = Exredis.query(worker, ["HGET", uuid, "last_action"])
            case id do
                :undefined -> :undefined
                _ -> UserSession.new_session(id, logged_in, last_action)
            end
        end)
    end

    def get_redis_sessions(:tokens, from, to) do
        :poolboy.transaction(:redis_pool, fn worker ->
            Exredis.query(worker, ["LRANGE", "user_sessions", from, to])
        end)
    end

    def get_redis_sessions(:expand, from, to) do
        get_redis_sessions(:tokens, from, to)
        |> Enum.map(fn token ->
            get_redis_session(token)
        end)
    end

    def get_redis_sessions(:tokens) do
        get_redis_sessions(:tokens, 0, -1)
    end

    def get_redis_sessions(:expand) do
        get_redis_sessions(:expand, 0, -1)
    end

    def get_redis_sessions() do
        get_redis_sessions(:tokens)
    end

    def delete_redis_session(uuid) do
        :poolboy.transaction(:redis_pool, fn worker ->
            Exredis.query(worker, ["MULTI"])
            Exredis.query(worker, ["DEL", uuid])
            Exredis.query(worker, ["LREM", "user_sessions", 0, uuid])
            Exredis.query(worker, ["EXEC"])
        end)
    end

    def session_expired?(uuid) when is_bitstring(uuid) do
        :poolboy.transaction(:redis_pool, fn worker ->
            last_action = Exredis.query(worker, ["HGET", uuid, "last_action"])

            case last_action do
                :undefined -> true
            end

            Timex.parse!(last_action, "%FT%T%:z", :strftime)
            
            time = Timex.Comparable.diff(Timex.now, last_action, :seconds)
            if time > 60 do
                true
            end
            false
        end)
    end

    def cleanup_session(uuid) do
        :poolboy.transaction(:redis_pool, fn worker ->
            Exredis.query(worker, ["LREM", "user_sessions", 0, uuid])
        end)
    end

    def session_expired?(user_session = %UserSession{}) do
        last_action = user_session.last_action
        |> Timex.parse!("%FT%T%:z", :strftime)
        
        time = Timex.Comparable.diff(Timex.now, last_action, :seconds)
        if time > 60 do
            true
        end
        false
    end

    def session_expire_seconds(uuid) when is_bitstring(uuid) do
        :poolboy.transaction(:redis_pool, fn worker ->
            last_action = Exredis.query(worker, ["HGET", uuid, "last_action"])
            |> Timex.parse!("%FT%T%:z", :strftime)
            Timex.Comparable.diff(Timex.now, last_action, :seconds)
        end)
    end

    def cleanup() do
        get_redis_sessions(:tokens)
        |> Enum.map(fn session -> 
            if session_expired?(session) do
                delete_redis_session(session)
            end
        end)
    end
end