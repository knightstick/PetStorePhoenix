defmodule PetStore.Repo.Migrations.CreatePets do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string

      timestamps()
    end

  end
end
