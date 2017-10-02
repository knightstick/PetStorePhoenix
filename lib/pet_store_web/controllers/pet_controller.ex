defmodule PetStoreWeb.PetController do
  use PetStoreWeb, :controller
  alias PetStore.Repo

  def index(conn, _params) do
    # This should be in the context
    pets = Repo.all(PetStore.Pets.Pet)
    render conn, pets: pets
  end

  def show(conn, %{"id" => id}) do
    # This should be in the context
    pet = Repo.get!(PetStore.Pets.Pet, id)
    render conn, pet: pet
  end
end
