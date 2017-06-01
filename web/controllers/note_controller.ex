defmodule Dsps.NoteController do
  use Dsps.Web, :controller

  alias Dsps.Note
  alias Dsps.User

  def index(conn, _params) do

    notes = Repo.all(Note)
    |> Enum.map(fn (x) ->
        user = Repo.get(User, x.user_id)
        IO.inspect(user)
        Map.put(x, :user, user)
     end)

    render(conn, "index.html", notes: notes)
  end

  def new(conn, _params) do
    changeset = Note.changeset(%Note{})

    current_amount = Repo.aggregate(Note, :count, :id)

    if current_amount >= 4 do
        conn
        |> put_flash(:info, "Maximum of 3 notes allowed.")
        |> redirect(to: page_path(conn, :index))
    end

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"note" => note_params}) do
    user_id = conn.assigns.user_data.id
    note_params = Map.put(note_params, "user_id", user_id)

    changeset = Note.changeset(%Note{}, note_params)

    current_amount = Repo.aggregate(Note, :count, :id)

    if current_amount >= 4 do
        conn
        |> put_flash(:info, "Maximum of 3 notes allowed.")
        |> redirect(to: page_path(conn, :index))
    end

    case Repo.insert(changeset) do
      {:ok, _note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Repo.get!(Note, id)
    render(conn, "show.html", note: note)
  end

  def edit(conn, %{"id" => id}) do
    note = Repo.get!(Note, id)

    user_id = conn.assigns.user_data.id

    if note.user_id == user_id do
        changeset = Note.changeset(note)
        render(conn, "edit.html", note: note, changeset: changeset)
    else
        conn
        |> put_flash(:info, "Can't edit foreign notes.")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Repo.get!(Note, id)
    changeset = Note.changeset(note, note_params)

    case Repo.update(changeset) do
      {:ok, _note} ->
        conn
        |> put_flash(:info, "Note updated successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", note: note, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Repo.get!(Note, id)

    user_id = conn.assigns.user_data.id

    if note.user_id == user_id do
        Repo.delete!(note)

        conn
        |> put_flash(:info, "Note deleted successfully.")
        |> redirect(to: page_path(conn, :index))
    else
        conn
        |> put_flash(:info, "Can't delete foreign notes.")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
