defmodule PetStore.Router do
  use PetStore.Web, :router

  pipeline :api do
    # Can we use JSON API here?
    plug :accepts, ["json"]
  end

  scope "/api", PetStore do
    scope "/v1" do
      pipe_through :api

      get "/pets", PetController, :index
    end
  end
end
