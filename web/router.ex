defmodule PetStore.Router do
  use PetStore.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PetStore do
    pipe_through :api
  end
end
