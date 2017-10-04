defmodule PetStoreWeb.Router do
  use PetStoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :json_api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", PetStoreWeb do
    scope "/v1" do
      pipe_through :json_api

      resources "/pets", PetController, only: [:index, :show]
    end
  end
end
