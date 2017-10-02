defmodule PetStore.PetControllerTest do
  use PetStore.ConnCase

  test "#index renders a list of pets" do
    conn = build_conn()
    pet = insert(:pet)

    conn = get conn, pet_path(conn, :index)

    assert json_response(conn, 200) == %{
      "data" => [
        %{
          "type" => "pets",
          "attributes" => %{
            "name" => pet.name,
          }
        }
      ]
    }
  end
end
