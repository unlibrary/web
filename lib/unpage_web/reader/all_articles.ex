defmodule UnPageWeb.App.AllArticles do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:title, "All articles")
      |> assign(:entries, make_call(UnLib.Entries.list_all(user())))

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def render(assigns) do
    render(UnPageWeb.ReaderView, "feed.html", assigns)
  end
end
