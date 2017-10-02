defmodule PetStoreWeb.PetController do
  use PetStoreWeb, :controller
  alias PetStore.Pets

  def index(conn, _params) do
    pets = Pets.list_pets
    render conn, pets: pets
  end

  def show(conn, %{"id" => id}) do
    pet = Pets.get_pet!(id)
    render conn, pet: pet
  end
end
