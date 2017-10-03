defmodule PetStoreWeb.PetControllerTest do
  use PetStoreWeb.ConnCase
  alias PetStoreWeb.PetView
  alias PetStoreWeb.ErrorView

  test "#index renders a list of pets" do
    conn = build_conn()
    pet = insert(:pet)

    conn = get conn, pet_path(conn, :index)

    assert json_response(conn, 200) ==
      render_jsonapi(PetView, "index.json", %{pets: [pet]})
  end

  describe "#show do" do
    test "Success renders a specific pet" do
      conn = build_conn()
      pet = insert(:pet)

      conn = get conn, pet_path(conn, :show, pet)

      assert json_response(conn, 200) ==
        render_jsonapi(PetView, "show.json", %{pet: pet})
    end

    test "Not Found renders a JSON API 404" do
      conn = build_conn()

      conn = get conn, pet_path(conn, :show, 123)

      assert json_response(conn, 404) ==
        render_jsonapi(ErrorView, "404.json", %{})
    end
  end
end
