defmodule PetStore.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case, async: true
      use Plug.Test

      import PetStore.Factory
      import PetStore.IntegrationCase
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PetStore.Repo)
  end

  def assert_primary_data_match(response, %{id: id} = expected) do
    json = response |> Poison.decode!
    %{ "data" => data } = json

    assert_id_matches(data, id)
    assert_resource_matches(data, expected)
  end

  # Move this elsewhere, then import?
  def assert_primary_data_match(response, expected) when is_list(expected) do
    json = response |> Poison.decode!
    %{ "data" => data } = json

    assert_ids_match(data, expected)
    assert_resources_match(data, expected)
  end

  def assert_errors_match(response, expected) do
    json = response |> Poison.decode!
    %{ "errors" => errors } = json

    assert errors == expected |> Enum.map(&stringify_keys/1)
  end

  defp assert_ids_match(data, expected) do
    actual_ids = Enum.map(data, fn fragment ->
      %{"id" => id } = fragment
      id
    end)

    expected_ids = Enum.map(expected, fn %{id: id} -> to_string(id) end)

    assert expected_ids -- actual_ids == [],
      "Expected ids #{inspect expected_ids}, got #{inspect actual_ids}"
    assert actual_ids -- expected_ids == [],
      "Expected ids #{inspect expected_ids}, got #{inspect actual_ids}"
  end

  defp assert_id_matches(data, id) do
    %{"id" => actual_id } = data

    assert to_string(id) == actual_id
  end

  defp assert_resources_match(data, expected) do
    Enum.map(expected, fn resource ->
      %{"attributes" => attributes } = Enum.find(data, fn fragment ->
        %{ "id" => id } = fragment
        id == to_string(resource[:id])
      end)

      expected_attributes = Map.drop(resource, [:id])
        |> stringify_keys()

      assert attributes == expected_attributes
    end)
  end

  defp assert_resource_matches(data, expected) do
    %{"attributes" => actual_attributes } = data

    expected_attributes = Map.drop(expected, [:id])
      |> stringify_keys()

    assert actual_attributes == expected_attributes
  end

  defp stringify_keys(map) do
    map
      |> Enum.reduce(%{}, fn ({key, value}, acc) ->
        Map.put(acc, to_string(key), value)
      end)
  end
end
