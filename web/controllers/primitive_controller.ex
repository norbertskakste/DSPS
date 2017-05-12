defmodule Dsps.PrimitiveController do
  use Dsps.Web, :controller
  alias Dsps.Primitive

  def new(conn, _params) do
    changeset = Primitive.changeset(%Primitive{})
    render conn, changeset: changeset
  end

  def index(conn, _params) do
    primitives = Repo.all(Primitive)
    render(conn, "index.html", primitives: primitives)
  end

  def create(conn, %{"primitive" => primitive_params}) do
    changeset = Primitive.changeset(%Primitive{}, primitive_params)

    case Dsps.Repo.insert changeset do
      {:ok, _changeset} ->
        conn
        |> put_flash(:info, "Primitive created")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create primitive")
        |> render("new.html", changeset: changeset)
    end
  end
end