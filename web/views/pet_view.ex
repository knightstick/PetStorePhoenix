defmodule PetStore.PetView do
  def render("index.json", %{pets: pets}) do
    %{
      data: Enum.map(pets, &pet_jsonapi/1)
    }
  end

  def render("show.json", %{pet: pet}) do
    %{
      data: pet_jsonapi(pet)
    }
  end

  # Guard or similar to only render pets?
  # Use a library to "adapt" to JSON API?
  # Maybe have an adapter as a module attribute?
  def pet_jsonapi(pet) do
    %{
      type: "pets",
      id: pet.id,
      attributes: %{
        name: pet.name
      }
    }
  end
end
