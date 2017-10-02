defmodule PetStore.Router do
  use PetStore.Web, :router

  pipeline :api do
    # Can we use JSON API here?
    plug :accepts, ["json"]
  end

  scope "/api", PetStore do
    scope "/v1" do
      pipe_through :api

      resources "/pets", PetController, only: [:index]
    end
  end
end
