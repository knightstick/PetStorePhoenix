defmodule ShowingAPetIntegrationTest do
  # Can we share this in some IntegrationCase?
  use ExUnit.Case, async: true
  use Plug.Test
  import PetStore.Factory
  alias PetStore.Router
  alias PetStore.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  @opts Router.init([])
  test "showing a pet" do
    pet = insert(:pet)

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

  defp jsonapi_resource(resource) do
    %{
      type: "pets",
      id: resource.id,
      attributes: %{name: resource.name}
    }
  end
end
