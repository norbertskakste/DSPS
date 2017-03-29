defmodule Dsps.PageController do
  use Dsps.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
