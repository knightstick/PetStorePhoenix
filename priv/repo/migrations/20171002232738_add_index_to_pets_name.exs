defmodule PetStore.Repo.Migrations.AddIndexToPetsName do
  use Ecto.Migration

  def change do
    create unique_index("pets", :name)
  end
end
