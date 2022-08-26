defmodule UnPageWeb.Pages.Index do
  @moduledoc false
  use UnPageWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, layout: {UnPageWeb.LayoutView, "page.html"}}
  end
end
