defmodule PetStoreWeb.PetView do
  use PetStoreWeb, :view
  use JaSerializer.PhoenixView

  location "/pets/:id"
  attributes [:name]
end
