# Should this be inside a context?
defmodule PetStore.Pet do
  use PetStore.Web, :model

  schema "pets" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  defimpl Poison.Encoder, for: PetStore.Pet do
    def encode(pet, _options) do
      pet
      |> Map.from_struct
      |> Map.drop([:__meta__, :__struct__])
      |> Poison.encode!
    end
  end
end
