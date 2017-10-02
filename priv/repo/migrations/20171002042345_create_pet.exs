defmodule PetStore.Repo.Migrations.CreatePet do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string

      timestamps()
    end
  end
end
