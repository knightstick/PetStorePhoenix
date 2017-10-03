defmodule PetStoreWeb.ErrorViewTest do
  use PetStoreWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  # Would be nice to pass through the detail
  test "renders 404.json" do
    assert %{errors: [error | []]} =
      render(PetStoreWeb.ErrorView, "404.json", [])

    %{status: status_string, title: title, detail: detail} = error

    assert status_string == "404"
    assert title == "Not Found"
    assert detail == "Not Found"
  end

  test "render 500.json" do
    assert render(PetStoreWeb.ErrorView, "500.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end

  test "render any other" do
    assert render(PetStoreWeb.ErrorView, "505.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end
end
