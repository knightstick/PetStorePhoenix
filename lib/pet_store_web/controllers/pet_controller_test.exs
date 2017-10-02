defmodule PetStoreWeb.PetControllerTest do
  use PetStoreWeb.ConnCase
  alias PetStoreWeb.PetView

  test "#index renders a list of pets" do
    conn = build_conn()
    pet = insert(:pet)

    conn = get conn, pet_path(conn, :index)

    assert json_response(conn, 200) ==
      render_jsonapi(PetView, "index.json", %{pets: [pet]})
  end

  test "#show renders a specific pet" do
    conn = build_conn()
    pet = insert(:pet)

    conn = get conn, pet_path(conn, :show, pet)

    assert json_response(conn, 200) ==
      render_jsonapi(PetView, "show.json", %{pet: pet})
  end
end
