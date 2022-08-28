defmodule UnPageWeb.App.Discover do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  alias UnPageWeb.App.Components.Source

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Discover")
      |> assign(:sources, make_call(UnLib.Sources.list()))

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end
end
