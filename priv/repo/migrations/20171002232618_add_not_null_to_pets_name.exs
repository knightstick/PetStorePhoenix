defmodule PetStore.Repo.Migrations.AddNotNullToPetsName do
  use Ecto.Migration

  def change do
    alter table("pets") do
      modify :name, :text, null: false
    end
  end
end
