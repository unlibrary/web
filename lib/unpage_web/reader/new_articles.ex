defmodule UnPageWeb.App.Feed.NewArticles do
  @moduledoc false
  use UnPageWeb, :live_view
  import UnPage.Daemon

  alias UnPageWeb.ReaderView

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:title, "New articles")
      |> assign(:page_title, "New articles")
      |> assign(:entries, make_call(UnLib.Entries.list_unread(user())))
      |> assign(:source, nil)

    {:ok, socket, layout: {UnPageWeb.LayoutView, "reader.html"}}
  end

  @impl true
  def render(assigns) do
    render(ReaderView, "feed.html", assigns)
  end

  @impl true
  def handle_event("read-all", _value, socket) do
    make_call(UnLib.Entries.read_all(user()))
    entries = make_call(UnLib.Entries.list_unread(user()))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("prune", _value, socket) do
    make_call(UnLib.Entries.prune(user()))
    entries = make_call(UnLib.Entries.list_unread(user()))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("pull", _value, socket) do
    make_call(UnLibD.pull_now())
    entries = make_call(UnLib.Entries.list_unread(user()))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("toggle-read-entry", %{"id" => entry_id}, socket) do
    {:ok, entry} = make_call(UnLib.Entries.get(entry_id))

    case entry do
      %{read?: false} -> make_call(UnLib.Entries.read(entry))
      _ -> {:ok, _entry} = make_call(UnLib.Entries.unread(entry))
    end

    entries = make_call(UnLib.Entries.list_unread(user()))

    {:noreply, assign(socket, :entries, entries)}
  end

  @impl true
  def handle_event("delete-entry", %{"id" => entry_id}, socket) do
    :ok = make_call(UnLib.Entries.delete(entry_id))
    entries = make_call(UnLib.Entries.list_unread(user()))

    {:noreply, assign(socket, :entries, entries)}
  end
end
