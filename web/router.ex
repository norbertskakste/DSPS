defmodule Dsps.Router do
  use Dsps.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Dsps.Plug.Session.Manager
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :put_secure_browser_headers
  end

  scope "/", Dsps do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/register", RegistrationController, only: [:new, :create]
    resources "/notes", NoteController

    resources "/primitives", PrimitiveController, only: [:index, :create]
    resources "/streams", StreamController, only: [:delete, :create, :edit, :index, :new, :show, :update] do
        resources "/variables", StreamVariableController, only: [:new, :create]
        get "/finalize", StreamController, :finalize
        get "/all_info", StreamController, :all_info
    end
    resources "/tables", TableController
    resources "/graphs", GraphController do
      get "/data", GraphController, :data
    end

    resources "/stream_graphs", StreamGraphController

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dsps do
  #   pipe_through :api
  # end
end
