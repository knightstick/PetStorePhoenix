defmodule ShowingAPetIntegrationTest do
  use ExUnit.Case, async: true
  use Plug.Test
  alias PetStore.Router
  alias PetStore.Repo

  alias PetStore.Pet

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  @opts Router.init([])
  test "showing a pet" do
    pet = %Pet{name: "Phoenix"} |> Repo.insert!

    conn = conn(:get, "/api/v1/pets/#{pet.id}")
    response = Router.call(conn, @opts)

    assert response.status == 200
    assert response.resp_body == jsonapi_response(pet)
  end

  # Do we in fact want guards instead of pattern matching?
  # Should this live in a library module somewhere?
  defp jsonapi_response(resource) do
    %{data: jsonapi_resource(resource)} |> Poison.encode!
  end

  defp jsonapi_resources(resources) do
    resources
    |> Enum.map(&jsonapi_resource/1)
  end

  defp jsonapi_resource(resource) do
    %{type: "pets", attributes: %{name: resource.name}}
  end
end
