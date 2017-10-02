defmodule PetStoreWeb.ConnCaseHelper do
  # Is this function name correct? It just delegates to the view
  def render_jsonapi(view, template, assigns) do
    view.render(template, assigns) |> format_json
  end

  defp format_json(data) do
    data |> Poison.encode! |> Poison.decode!
  end
end
