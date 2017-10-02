defmodule PetStore.PetController do
  use PetStore.Web, :controller
  alias PetStore.Pet

  def index(conn, _params) do
    pets = Repo.all(Pet)
    render conn, pets: pets
  end

  def show(conn, %{"id" => id}) do
    pet = Repo.get!(Pet, id)
    render conn, pet: pet
  end
end
