defmodule FawkesWeb.Router do
  use FawkesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FawkesWeb do
    pipe_through :api
  end

  scope "/api", FawkesWeb do
    post "/create", MainController, :create
    get "/show", MainController, :show
  end
end
