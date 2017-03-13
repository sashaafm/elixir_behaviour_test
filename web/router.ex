defmodule MongoPoc.Router do
  use MongoPoc.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MongoPoc do
    pipe_through :api

    post "/users/create", UserController, :create
  end
end
