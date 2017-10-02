defmodule PetStore.PetControllerTest do
  use PetStore.ConnCase

  test "#index renders a list of pets" do
    conn = build_conn()
    pet = insert(:pet)

    conn = get conn, pet_path(conn, :index)

    assert json_response(conn, 200) ==
      render_jsonapi("index.json", pets: [pet])
  end

  test "#show renders a specific pet" do
    conn = build_conn()
    pet = insert(:pet)

    conn = get conn, pet_path(conn, :show, pet)

    assert json_response(conn, 200) == render_jsonapi("show.json", pet: pet)
  end

  defp render_jsonapi(template, assigns) do
    assigns = Map.new(assigns)

    PetStore.PetView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
