defmodule ListingPetsIntegrationTest do
  use PetStore.IntegrationCase
  alias PetStoreWeb.Router

  @opts Router.init([])
  describe "listing pets" do
    setup _context do
      conn = conn(:get, "/api/v1/pets")

      {:ok, conn: conn}
    end

    test "listing a pet", %{conn: conn} do
      pet = insert(:pet)
      response = Router.call(conn, @opts)

      assert response.status == 200

      expected = [%{name: pet.name, id: pet.id}]
      assert_primary_data_match response.resp_body, expected
    end

    test "listing more pets", %{conn: conn} do
      pets = [insert(:pet), insert(:pet)]
      response = Router.call(conn, @opts)

      assert response.status == 200

      expected = pets
                 |> Enum.map(fn pet -> %{name: pet.name, id: pet.id} end)

      assert_primary_data_match response.resp_body, expected
    end
  end
end
