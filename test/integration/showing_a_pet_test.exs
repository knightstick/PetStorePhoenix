defmodule ShowingAPetIntegrationTest do
  # Can we share this in some IntegrationCase?
  use ExUnit.Case, async: true
  use Plug.Test
  import PetStore.Factory
  alias PetStoreWeb.Router
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

  test "showing a pet that doesn't exist" do
    conn = conn(:get, "/api/v1/pets/123")
    response = Router.call(conn, @opts)

    assert response.status == 404
    assert response.resp_body == jsonapi_error(:not_found)
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

  defp jsonapi_error(:not_found, detail \\ "Not Found") do
    %{
      errors: [
        %{
          status: "404",
          title: "Not Found",
          detail: detail
        }
      ]
    } |> Poison.encode!
  end
end
