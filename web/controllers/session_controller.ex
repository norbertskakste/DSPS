defmodule Dsps.SessionController do
    use Dsps.Web, :controller

    def new(conn, _params) do
        render conn, "new.html"
    end

    def create(conn, %{"session" => session_params}) do
        case Dsps.Session.login(session_params, Dsps.Repo) do
            {:ok, user} ->
                conn
                |> Dsps.Session.create_session(user)
                |> put_flash(:info, "Logged in")
                |> redirect(to: "/")
            :error ->
                conn
                |> put_flash(:info, "Wrong username or password")
                |> render("new.html")
        end
    end

    def delete(conn, _) do
        IO.puts("AYY")
        conn
        |> Dsps.Session.delete_session
        |> put_flash(:info, "Logged out")
        |> redirect(to: "/")
    end
end