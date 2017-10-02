defmodule PetStoreWeb.Router do
  use PetStoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PetStoreWeb do
    scope "/v1" do
      pipe_through :api

      resources "/pets", PetController, only: [:index, :show]
    end
  end
end
