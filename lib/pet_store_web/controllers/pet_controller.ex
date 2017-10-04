defmodule PetStoreWeb.PetController do
  use PetStoreWeb, :controller
  alias PetStore.Pets
  alias PetStoreWeb.ErrorView

  def index(conn, _params) do
    pets = Pets.list_pets

    render(conn, %{data: pets})
  end

  def show(conn, %{"id" => id}) do
    case Pets.get_pet(id) do
      nil -> render_error(conn, :not_found)
      pet -> render(conn, data: pet)
    end
  end

  # Can we delegate this to JaSerializer?
  defp render_error(conn, :not_found) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", [])
  end
end
