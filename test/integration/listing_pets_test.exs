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
    pets = Repo.all(Pet) |> Poison.encode!

    conn = conn(:get, "/api/v1/pets")
    response = Router.call(conn, @opts)

    assert response.status == 200
    assert response.resp_body == pets
  end
end
