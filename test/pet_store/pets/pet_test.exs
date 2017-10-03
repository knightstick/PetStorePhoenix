defmodule PetStore.PetTest do
  use PetStore.DataCase
  alias PetStore.Pets.Pet

  describe "changeset" do
    @valid_attrs %{name: "Phoenix"}

    test "is valid with a name" do
      changeset = Pet.changeset(%Pet{}, @valid_attrs)

      assert changeset.valid?
    end

    test "is not valid without a name" do
      attrs = @valid_attrs |> Map.drop([:name])
      changeset = Pet.changeset(%Pet{}, attrs)

      refute changeset.valid?
    end

    # This might be a bit strict, will have to think about it
    test "is not valid if the name is a duplicate" do
      Pet.changeset(%Pet{}, @valid_attrs) |> Repo.insert!
      dupe_pet = Pet.changeset(%Pet{}, @valid_attrs)

      assert {:error, changeset} = Repo.insert(dupe_pet)
      { message, _ } = changeset.errors[:name]

      # Can we I18n or strings-file this?
      assert message == "has already been taken"
    end
  end
end
