defmodule ListingPetsIntegrationTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import PetStore.Factory
  alias PetStoreWeb.Router
  alias PetStore.Repo

  alias PetStore.Pets.Pet

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  @opts Router.init([])
  test "listing pets" do
    insert(:pet)
    pets = Repo.all(Pet)

    conn = conn(:get, "/api/v1/pets")
    response = Router.call(conn, @opts)

    assert response.status == 200
    assert response.resp_body == jsonapi_response(pets)
  end

  # Should this live in a library module somewhere?
  defp jsonapi_response(resources) when is_list(resources) do
    %{data: jsonapi_resources(resources)} |> Poison.encode!
  end

  defp jsonapi_resources(resources) do
    resources
    |> Enum.map(&jsonapi_resource/1)
  end

  defp jsonapi_resource(resource) do
    %{
      type: "pets",
      id: resource.id,
      attributes: %{name: resource.name}
    }
  end
end
