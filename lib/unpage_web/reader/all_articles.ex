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
      |> assign(:show_mark_all_read_button?, true)

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def render(assigns) do
    render(UnPageWeb.ReaderView, "feed.html", assigns)
  end

  @impl true
  def handle_event("all-read", _value, socket) do
    make_call(UnLib.Entries.read_all(user()))
    entries = UnLib.Entries.list_all(user())

    {:noreply, assign(socket, :entries, entries)}
  end
end
