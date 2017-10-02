defmodule ListingPetsIntegrationTest do
  use ExUnit.Case, async: true
  use Plug.Test
  alias PetStore.Router
  alias PetStore.Repo

  alias PetStore.Pet

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  @opts Router.init([])
  test "listing pets" do
    %Pet{name: "Phoenix"} |> Repo.insert!
    pets = Repo.all(Pet)

    conn = conn(:get, "/api/v1/pets")
    response = Router.call(conn, @opts)

    assert response.status == 200
    assert response.resp_body == jsonapi_response(pets)
  end

  # Do we in fact want guards instead of pattern matching?
  # Should this live in a library module somewhere?
  defp jsonapi_response([head | tail] = resources) do
    %{data: jsonapi_resources(resources)} |> Poison.encode!
  end

  defp jsonapi_resources(resources) do
    resources
    |> Enum.map(&jsonapi_resource/1)
  end

  defp jsonapi_resource(resource) do
    %{type: "pets", attributes: %{name: resource.name}}
  end
end
