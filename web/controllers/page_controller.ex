defmodule Dsps.PageController do
  use Dsps.Web, :controller

  def index(conn, _params) do
    notes = Repo.all Dsps.Note

    render conn, "index.html", notes: notes
  end
end
