defmodule PetStore.Factory do
  use ExMachina.Ecto, repo: PetStore.Repo

  # Can we use something similar to Faker?
  def pet_factory do
    %PetStore.Pets.Pet{
      name: sequence(:name, &"Phoenix #{&1}")
    }
  end
end
