defmodule PetStore.Pets.Pet do
  use Ecto.Schema
  import Ecto.Changeset
  alias PetStore.Pets.Pet

  schema "pets" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Pet{} = pet, attrs) do
    pet
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
