defmodule PetStore.PetView do
  def render("index.json", %{pets: pets}) do
    pets
  end
end
