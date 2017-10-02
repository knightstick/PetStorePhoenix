defmodule PetStore.PetViewTest do
  use PetStore.ModelCase
  import PetStore.Factory
  alias PetStore.PetView

  test "pet_jsonapi" do
    pet = insert(:pet)

    rendered_pet = PetView.pet_jsonapi(pet)

    assert rendered_pet == %{
      type: "pets",
      id: pet.id,
      attributes: %{
        name: pet.name
      }
    }
  end

  test "index.json" do
    pet = insert(:pet)

    rendered_pets = PetView.render("index.json", %{pets: [pet]})

    assert rendered_pets == %{
      data: [PetView.pet_jsonapi(pet)]
    }
  end

  test "show.json" do
    pet = insert(:pet)

    rendered_pet = PetView.render("show.json", %{pet: pet})

    assert rendered_pet == %{
      data: PetView.pet_jsonapi(pet)
    }
  end
end
