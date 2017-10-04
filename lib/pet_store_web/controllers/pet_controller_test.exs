defmodule PetStoreWeb.PetControllerTest do
  use PetStoreWeb.ConnCase
  alias PetStoreWeb.PetView
  alias PetStoreWeb.ErrorView

  test "#index renders a list of pets" do
    conn = build_conn()
    pet = insert(:pet)

    conn = get conn, pet_path(conn, :index)

    assert json_response(conn, 200) ==
      render_json(PetView, "index.json-api", %{data: [pet]})
  end

  describe "#show do" do
    test "Success renders a specific pet" do
      conn = build_conn()
      pet = insert(:pet)

      conn = get conn, pet_path(conn, :show, pet)

      assert json_response(conn, 200) ==
        render_json(PetView, "show.json-api", %{data: pet})
    end

    test "Not Found renders a JSON API 404" do
      conn = build_conn()

      conn = get conn, pet_path(conn, :show, 123)

      assert json_response(conn, 404) ==
        render_json(ErrorView, "404.json", %{})
    end
  end
end
