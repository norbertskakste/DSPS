defmodule Dsps.RegistrationController do
    use Dsps.Web, :controller
    alias Dsps.User

    def new(conn, _params) do
        changeset = User.changeset(%User{})
        render conn, changeset: changeset
    end

    def create(conn, %{"user" => user_params}) do
        changeset = User.changeset(%User{}, user_params)

        case Dsps.Registration.create(changeset, Dsps.Repo) do
            {:ok, changeset} ->
                uuid = UUID.uuid4 <> "." <> UUID.uuid1
                conn
                |> put_session(:current_user, uuid)
                |> Dsps.Session.set_user(uuid, changeset)
                |> put_flash(:info, "Account registered")
                |> redirect(to: "/")
            {:error, changeset} ->
                conn
                |> put_flash(:info, "Unable to create account")
                |> render("new.html", changeset: changeset)
        end
    end
end