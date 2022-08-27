defmodule UnPageWeb.App.Source do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok, source} = make_call(UnLib.Sources.get(id))

    socket =
      socket
      |> assign(:title, source.name)
      |> assign(:entries, make_call(UnLib.Entries.list_all(source)))

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def render(assigns) do
    render(UnPageWeb.ReaderView, "feed.html", assigns)
  end
end
