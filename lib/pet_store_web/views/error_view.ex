defmodule PetStoreWeb.ErrorView do
  use PetStoreWeb, :view

  @not_found_base %{status: "404", title: "Not Found"}

  def render("404.json", _assigns) do
    %{errors: [not_found_json()]}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end

  defp not_found_json(detail \\ "Not Found") do
    Map.put(@not_found_base, :detail, detail)
  end
end
