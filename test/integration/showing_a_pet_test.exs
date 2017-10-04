defmodule ShowingAPetIntegrationTest do
  use PetStore.IntegrationCase
  alias PetStoreWeb.Router

  @opts Router.init([])
  describe "showing a specific pet" do
    setup _context do
      pet = insert(:pet)
      conn = conn(:get, "/api/v1/pets/#{pet.id}")

      {:ok, conn: conn, pet: pet}
    end

    test "showing a pet", %{conn: conn, pet: pet} do
      response = Router.call(conn, @opts)

      assert response.status == 200

      expected = %{name: pet.name, id: pet.id}
      assert_primary_data_match response.resp_body, expected
    end

    test "showing a pet that doesn't exist", %{conn: conn, pet: pet} do
      PetStore.Pets.delete_pet(pet)
      response = Router.call(conn, @opts)

      assert response.status == 404

      expected = [%{
        status: "404",
        title: "Not Found",
        detail: "Not Found"
      }]

      assert_errors_match response.resp_body, expected
    end
  end
end
