defmodule Dsps.Plug.Session do
    defmodule Manager do
        import Plug.Conn

        def init(opts), do: opts

        def call(conn, _opts) do
            uuid = get_session(conn, :user_session)
            case uuid do
                nil ->
                    conn
                    |> assign(:is_logged_in, false)
                    |> assign(:user_data, nil)
                    |> assign(:session_data, nil)
                _ ->
                    session_data = Dsps.Redis.Session.get_redis_session(uuid)
                    case session_data do
                        :undefined ->
                            Dsps.Redis.Session.cleanup_session(uuid)
                            conn
                            |> delete_session(:user_session)
                            |> assign(:is_logged_in, false)
                            |> assign(:user_data, nil)
                            |> assign(:session_data, nil)
                        _ ->
                            user_data = Dsps.Repo.get(Dsps.User, session_data.id)
                            conn
                            |> assign(:is_logged_in, true)
                            |> assign(:user_data, user_data)
                            |> assign(:session_data, session_data)
                    end
            end
        end
    end
end